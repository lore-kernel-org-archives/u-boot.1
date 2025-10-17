Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F81CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 08:22:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB50683631;
	Fri, 17 Oct 2025 10:22:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="NEY6RawJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAAFD83655; Fri, 17 Oct 2025 10:22:19 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 909E4807B1
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 10:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngDo5XzwaWJoj+aXUFCXwUTNfGMTbDjTvStHWw8d9d7kdL6y1MnEth72RUFR3pd2sk6fOVTVa27xWON9kD/MVc/4w3Zyl0NLg/kQWs0NNpUixDcJVxOtdiMSvz7Akql8Tmpbsa5LHVhkvOhOLqr59xeUrDtH1VYPnBzuXDbr6qtFisg+8ybcq25HBO2Pnqw8OPq/z0mhELeionwz24cXBlniaiWVZzsL2MNyak3jJmgZvaXiW5XeM56QXau5ZKhP32mDm+ff7k0JoanxRLoP+P8aD9R5qiGHuUEsLkfEWrwNFZLnj8b0RhFlzSOd9aXMO8oo2kjXIGBn+hF7jdCaFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNbe5ZkaEM0K0BKRBnCi2icI+1lWodNRnkFOmiiqTyE=;
 b=IGmpgu3yUqUnwfNgcaLYKO+ObGP3vGgOAzfi2jWIkED4jbwgEJJE+bcpSUGbECzMPJC1vUAYVSDvGBzpSiTR/T2b2dMtBpErEZws5CvVqihr3WHlHejhHa6mBy5poBKg2zZwjyUwrnyZjr6VAtJY80R5LME113NmFisLP+aOIbFwbe9QovUDrDAlHm2RzuWYtor7OiLUI27G0s/NPo099riSfmX40JHMmeotCGOniCAlFrTCizzhjkw7WL7N573P0lf+LXJTLeFQ4nOQiXrHs/ttqkCUfhuhiR5EFZXDuIWr8Go0Cq9nBqO1FC3qYk8qAWpkzzhpjz2Z84WADLRAIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNbe5ZkaEM0K0BKRBnCi2icI+1lWodNRnkFOmiiqTyE=;
 b=NEY6RawJdsPNcc7RHzT8APFx9G0UomFNOiRIc4YwaO91Xv+H45gC5wUsqLVvIx2k8WBf4codef+GnzIdlbAYTLsw6NkfJl2DnHQkUuR/jVg5fWTJl1XJrvdzXqSWSl53mdyBTZJtmNcKLo9brRtyj7NmaBsM8wQ3NnPnQthukBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB6226.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 08:22:12 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9228.005; Fri, 17 Oct 2025
 08:22:12 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: <u-boot@lists.denx.de>,  Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] cmd/part.c: implement "part name" subcommand
In-Reply-To: <6e85c247-9624-472c-bbdb-b35be4fa03a4@cherry.de> (Quentin
 Schulz's message of "Thu, 16 Oct 2025 15:28:25 +0200")
References: <20251016125247.1594643-1-ravi@prevas.dk>
 <6e85c247-9624-472c-bbdb-b35be4fa03a4@cherry.de>
Date: Fri, 17 Oct 2025 10:22:02 +0200
Message-ID: <87ecr2ndjp.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::29) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: c419ef46-65fc-4f46-5b0a-08de0d56457f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YyUvhkUDYY38FAPl22nj9il/yM7vh406dEeTLr+Ly3FDaHqsLodcO2sQb+CO?=
 =?us-ascii?Q?BidtoC1tHAyvY7pcChpsuoI0icohs0BeyEyx9pFcpTW+Udrm4CpNhJCwkyiD?=
 =?us-ascii?Q?eZZNNxIyeKrVLcRQA8G7CAhqZOaPmmiXoQidFrTJJPJaR/oC0a1ExNsO8Qpw?=
 =?us-ascii?Q?4DKll/uyKlzwudRA7PE+moTgLcTxNh0vBsbiKsJWAl6ROuAnbB5z59q3hKi8?=
 =?us-ascii?Q?Qz4ApofyYmowFi9LyPfA6tHLqaz3UHoVPKSIHZfXTXpFVz+wP02jYgVAU7Yy?=
 =?us-ascii?Q?Ncbb9IhTudqUxo0VWMSCfYI1yH1QlYxFmhqXb0hHJYIUin+GQvx9sOff+7If?=
 =?us-ascii?Q?hpLFFkzXOrK+whtqp9nhjAz9e1XcOY7vJAsMc1JsQmGJDuSzlgqU5QfwiNZU?=
 =?us-ascii?Q?oJwExXXCFk/4rgj/eFqYiVwSttLvVXNMsLOEk8ebdLWrshmsqyDm4tbyqoiO?=
 =?us-ascii?Q?Q1tps2AycMLX7s0WmNQnr7qnFo4k9Qd7HMqICQGGRlyAtDair2SAq4zFFDTK?=
 =?us-ascii?Q?qgC+XjR7VhYIbP90wCS8PHP4fw7gWS1s6ZgxnvEsJjhlBfbdI4jXhXnUgHu3?=
 =?us-ascii?Q?LAy5ZAVJTz9MT8fe6FmuliIEnyeuVTkArH4662clpK9FMOkcecjc5JcaayC7?=
 =?us-ascii?Q?l/4ntgFbvfSBUjUHrbSeYRIc/uvCGAlKL/HVzlDV486FdDKu2Tg1yoNpli0O?=
 =?us-ascii?Q?4/X8WJe9wbesL2x4j/R51tHe+PMlUvZHcIz9Ui1KL/FG//4FI6XKGdFtp5j1?=
 =?us-ascii?Q?D+EzUt9FIn/zhKb1l4Ku1OPgEVMLfCP+hIKZzF4CGCozmuikn3crOeEorbFo?=
 =?us-ascii?Q?wb8RIvGh7Xg3OLXVf3IS5uMG2U4IKu66MXkuqJPR37eARtjSkEXBipTAliab?=
 =?us-ascii?Q?pUrYvgzud+qb2Jsqh4j0oU0pt03TQYd9H8mgaHydUrEgam1XU4pbNQ4FWxcK?=
 =?us-ascii?Q?CIzmtmLM+Qf5iHIzbNGEjHM8kY0m34yQAoGRewcPTW9kWRp2cCR3H99NE50v?=
 =?us-ascii?Q?1Tt675zi0Kf2CfuAIJNicXnHbIxUqdWoXUn35Ccq45or/68TFUiaE8BVmD/t?=
 =?us-ascii?Q?WD2iVSadhdH7ZzrJPGXPaQHqEDFa+FeiNpNauMUURL6YoGH1O7LH1bhs9Fyh?=
 =?us-ascii?Q?Tx61/41M4dc/0hPwONRLwxM83rSlDwKHVuV6eq9MtJwEdi03PGhCBAaYgtVo?=
 =?us-ascii?Q?arTU++iI44KcyGA/NkxTMxVrerhDbB+/O2HuF/oF7Slo8vTSSk9fMFD5hJsH?=
 =?us-ascii?Q?pxF/1cdGn3AKbxkGjUXMEuwK69QoA37QU9Rli9KQsutypH0cbiuvQ9cWC37y?=
 =?us-ascii?Q?UHAYV6aJDam1W3vN4hsO1tWQLfqce62NG7ktU42vn1/I3jwzSaBb2paWiku5?=
 =?us-ascii?Q?5AXVBBHsBE3wPqS7hR3IsOMWntsbFTj0tYs1WmH6YkYA8EwbcQ9Qc+OtePPh?=
 =?us-ascii?Q?FNtWpKQYPSX4PWcpTvHiANpXLJld6B8081J95O4AXiafkFpUUSA68e3W69rJ?=
 =?us-ascii?Q?ET89hpSnDYNwH6L/sa199XTaDIsEoAYBMvtj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F74z+f22KaogZCtQI0Srhz+gVcMUXDwE1Bh6/gOfhsWfJDHg8sC0jyVWOCOu?=
 =?us-ascii?Q?J3LlmKyfeTX6DIOzC1STfXbq1Sy+tFhpcB+b4IoYn2nWvIUZzQcNA5Sa9f9v?=
 =?us-ascii?Q?utYPZ0fKmJXK1TbBdNgZgDjMIflgdLngJhginwrsyS6wk/2ufu6MErzDJA91?=
 =?us-ascii?Q?SjizkvO1OdCO/mqUHd0mqdUUcyOGNDLAOshVTnk0QkQxfqvn/xQV5Byr/W/t?=
 =?us-ascii?Q?BfWtcI0SKzMvFSvRMahzGWZQcIefkQMILu0s4OHvIoKMuL3xLbjy1hYPXYkJ?=
 =?us-ascii?Q?AcxFw0NyEq5pjGPQAxRH7ShqyPpQLHNdlgOkPAw/AAfkgUpP+0vzUX3V5ufc?=
 =?us-ascii?Q?G0NQzMIff9+gG3iG0hdJ+8qiEo01Y+rQ6GPkNfAveNows8Odf4DFNWYWWPGb?=
 =?us-ascii?Q?YMI6KSE5Q2WBC45tUr5Lc+9eW5pa9I1VPJgWUOsElk+AClVE0SGkhVdQUIkZ?=
 =?us-ascii?Q?JsoLVs0JcDtyuDD5qShFfNBTWT4Vf2gkvkelVb9bfhjPSpgFNNgw+d5drlK+?=
 =?us-ascii?Q?pl/pzo+deMr++H8t0LO7qTl6kM/QzA8ATI6NAwCqyIayVEFTzF39GO5C4VkD?=
 =?us-ascii?Q?EdPthnXKy2t66eZs6Kg0gz1C6OUUQarmcQnuq0U/dyJG/c5i1XJ4O+t1szt/?=
 =?us-ascii?Q?pZOKjt9g+TmFDV5QmqcmKaB+eRytlefZuMXzn4+iCyTnRpKRMesT9uw3Kjqg?=
 =?us-ascii?Q?a27ZSDyPkrq8OI+2u2a01WFL4oy1FkfQg82+ygMUbHsFe1Di8HTmplPtzfqH?=
 =?us-ascii?Q?gU/11JxpYRZYMpmToTDzLWKHDLAxV9sBN9nfhUQtgIrcbZRezNhIZ86/iLps?=
 =?us-ascii?Q?svL8EAQTvemOUdpq8C7WBlTJPsTa5mti06123ldoFIXGZVgpHMni5sUk7rVJ?=
 =?us-ascii?Q?SQ+2fkmw31lV7IMXdDsM0F/HqHNrbGkpfGW8b7Di9FEy3DUORKp+JIVkA9LG?=
 =?us-ascii?Q?YUGGxMBDtzdBxBOnIvmYXEXvTc35deemw4TBgpx5877um+j271dIjDrf4uEF?=
 =?us-ascii?Q?b+fyxFN/nbV6yFXeAz5X+1lg7pslsT6/og48dl7FjSmKMuqNrRq2urapLkIC?=
 =?us-ascii?Q?CSo6FuvNXfxVePWErkWfRMF7WSuI5zTfzJk1IvJDiDOUJTq5AOvNUz71eNaA?=
 =?us-ascii?Q?t56O0jSpP9hReTJHdRWhRzZs6IPR+yOHJNEoKGt367HME/xesD4wmrw5bdqD?=
 =?us-ascii?Q?U3hArRqsqv+kZT9i9rWXhH7dWGnAwWfflvptlWA83u3jDvzjXCii3HnjHqBy?=
 =?us-ascii?Q?fgq/KlnvSTfeIfpvtGdzohS6+qilfXgJyGDiqc2ue1MhrdcbMBDkr7TNDRDU?=
 =?us-ascii?Q?hvyNYKya9QnrkVZ+GA1f57fEVQDy0Cmg3Do0aQb+FoQFbt/v88nbGUrIH5oz?=
 =?us-ascii?Q?pg9hcPESZauZweiZRRWgDDN3ovEtcOmbNdKV0lCPRHZOWJed7WUVxyIqIgjT?=
 =?us-ascii?Q?7O24//uV0/NRx2ELhVU9oe3UvCbdPLcujikQusZ1zh2DLWsB6yy1wNtCIDlJ?=
 =?us-ascii?Q?PS22AhkEDl7sKGfAAIRQKjrjsfrUxfeIx8iwKWWErgCq1d/JOVVKJ5kZi+7C?=
 =?us-ascii?Q?hGyFdDpivSfIRC9soiDE59GiaKoNJBKer+veO6WbOIdb9OBpilnzVmxk3hl5?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c419ef46-65fc-4f46-5b0a-08de0d56457f
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:22:12.0195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAfQb5zIObRH8QRNEOTmvusJBX5kyJRbIcf5SV8uNFmf/0cD2+Q+uIPgdt1+PNODkNCkvCsOflloHYqIm9iq1bi4XxnkMVPKXk+Vfaxas9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6226
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Thu, Oct 16 2025, Quentin Schulz <quentin.schulz@cherry.de> wrote:

> Hi Rasmus,
>
> On 10/16/25 2:52 PM, Rasmus Villemoes wrote:
>> This is a natural buddy to the existing "part number", allowing one to
>> get the partition name for a given partition number.
>> 
>
> Can you update the documentation in doc/usage/cmd/part.rst as well?

Will do, thanks.

>>   cmd/part.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>> diff --git a/cmd/part.c b/cmd/part.c
>> index db7bc5819c0..975a0a08a99 100644
>> --- a/cmd/part.c
>> +++ b/cmd/part.c
>> @@ -25,7 +25,8 @@
>>   enum cmd_part_info {
>>   	CMD_PART_INFO_START = 0,
>>   	CMD_PART_INFO_SIZE,
>> -	CMD_PART_INFO_NUMBER
>> +	CMD_PART_INFO_NUMBER,
>> +	CMD_PART_INFO_NAME,
>>   };
>>     static int do_part_uuid(int argc, char *const argv[])
>> @@ -154,6 +155,9 @@ static int do_part_info(int argc, char *const argv[], enum cmd_part_info param)
>>   	case CMD_PART_INFO_NUMBER:
>>   		snprintf(buf, sizeof(buf), "0x%x", part);
>>   		break;
>> +	case CMD_PART_INFO_NAME:
>> +		snprintf(buf, sizeof(buf), "%s", info.name);
>
> Is it possible info.name is never set by the fs/blk driver? Should we
> initialize this field?
>

So I took a look, and it seems that all but part_amiga.c do initialize
it.

- iso and dos uses part_set_generic_name()

- mac and efi have real data from the partition table to put in

- mtd also initializes name, either from a name defined in mtdparts or a
  size@offset generated one

- ubi uses the volume name

I suppose we should make sure info.name is zero-initialized (or, at
least, that info.name[0] is 0 so there's a valid C string). But I think
that shouldn't have to be the responsibility of every caller of
part_get_info(). IOW, I think we should just add

	info->name[0] = '\0';
	info->type[0] = '\0';

into part_get_info_by_type(), and then that's a separate patch. WDYT?

Rasmus
