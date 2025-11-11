Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFA2CCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 07:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB97883AB4;
	Tue, 11 Nov 2025 08:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="VImENnPc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A585083AE9; Tue, 11 Nov 2025 08:58:11 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 167B083A79
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 08:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFehlLWqU4gRr9FUlPi/CV/zEsRZhr6TbUnNHM+ldiMjllTV1AJ9wgQyizAgnlnPGWJP5mn/c6JIJr8Yijzr0Lj4b6PtLPi4CFIVqh7GnmNDvLzuBuxdoeWWYBmNFzS6gqbiOUoAzd2vOEyjsxGMrk6pp3yIlGXMSwQGvUlsv9m5vJvtBtvPqlVlZJVjP/qbdzvpaSjfReogyylds4hV6JQTSstd99bxkyDkep+BqVBjZ5KCcjs5dz1valJPLCElolHOWDOHba1k6WPoUxk/XSG/IpiHZ4p1zlXbE2GUFWydyAEEbBGeI2qzwNIYLQRhap/4TZVP4ERbg+TY4vuoyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4z19fRtx8FNpvnJklsxRoKyR83ifVmJf6fQzzNYazxw=;
 b=at6u4/+a9uuywo4JVeeuYwqElFXvK3j36RRK0eVwujsusRrpUtFEyPwcaEPnjay4XHyaPLMIZ9ixR4sGwFWYlr4dy1effrBjTncwRmming9ewyBanDY/m/uZnfOFsBhxRxmgzmkiME6ER2gwYOeOVUshP7NGPzY2O5YVNcTW61GbUAV95niXgr7fxqc+nywQiMHUcFgUU+RSM8OERRx5wsdKogouQDnX180jG28vooLJqfCmVC4BHXaqENWLAvHGztEtBTGhhD+raqb6ox3V0UeT1fIgxaTZq56iEeWB1bPWdDYZVh4hRDBpn6B+/SHaFaBgnDrab+gG/OI8TVD96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4z19fRtx8FNpvnJklsxRoKyR83ifVmJf6fQzzNYazxw=;
 b=VImENnPcj4boJUhbVStpQbKHfAH/1jPID/H3TphA2FyzmaALJACIaPLi/r0fh4ZKKzdcnBXJMTWafjCaKZUz3xvd3ZQGy6ZIJMkHQnA7PnL2gtksg6MBQan+ejucvx0GKw8L328kXQPyJS5vDUXOv530j+6cEHZuWDg8FQR5jfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB4PR10MB6166.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:389::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:58:06 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9275.013; Tue, 11 Nov 2025
 07:58:05 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Anshul Dalal <anshuld@ti.com>
Cc: <u-boot@lists.denx.de>,  Quentin Schulz <quentin.schulz@cherry.de>,  Tom
 Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 1/2] disk/part.c: ensure strings in struct
 disk_partition are valid after successful get_info
In-Reply-To: <DE5M18VIB15A.2TVG99O546D0T@ti.com> (Anshul Dalal's message of
 "Tue, 11 Nov 2025 10:48:49 +0530")
References: <20251110205411.4075351-1-ravi@prevas.dk>
 <20251110205411.4075351-2-ravi@prevas.dk>
 <DE5M18VIB15A.2TVG99O546D0T@ti.com>
Date: Tue, 11 Nov 2025 08:58:02 +0100
Message-ID: <87h5v1c86t.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::18) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB4PR10MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: b124dce8-0408-4fe3-9280-08de20f80bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zqMc79X+zFgXhBqaXIdA3MBzdkRt2UPVSC9MxiFMnBZnsD0DrIehdx+9o7in?=
 =?us-ascii?Q?owFvJ6I4ZT1RDnJ7RB780rvg2/Om7cfiO6CWoPvcRCaI/QL+6hE3LVXqYf0M?=
 =?us-ascii?Q?ObRgzdm37nC3QtgAitkFKgoJ9NJ1hXrFnsodBUJPte2rg8j/52wrJwwOpy89?=
 =?us-ascii?Q?sgrBKNEzFMl6VG71FxORQeyYkDp2h4H/4FyfJDctCK8pbGWlyuJ9fsnmauwJ?=
 =?us-ascii?Q?xGGug73dmTQdBDjKQTJ7t8E8/hycnRezrqsmcE+6b0uIxuPeq2v7hlOrkGdP?=
 =?us-ascii?Q?Y8Uirz0sjWV/6lH6Boj/kykuHrpvjk4KNJ5wAMWp6y4wAyvf++fuXlOT2tXP?=
 =?us-ascii?Q?9QsJq73zYMvlmxVUQ69O8/GIgF7MiKdristzVxl3iu2EQFDAAerSabO+PaC4?=
 =?us-ascii?Q?GNxvvh0+4tjsyAoYfVB24ezvhiAaYQ33aSOJA0QFngoRIpeWMDtCvWsxaGye?=
 =?us-ascii?Q?xpY+mTv7bIpfyMYvbLOKLD3/nhwgjmN5ya194F9MOs/mp3Q47awYKKIf6ZFL?=
 =?us-ascii?Q?7HTgHvBonYhwxU800O91A/VXUtQ8G40cfcnVY8vzCIWSCxJQVcKX7lomSKca?=
 =?us-ascii?Q?uxthK72wpvKdp+PibK6hPH3BggS7DMnJAIHOJnEwptMmgfa6o5cvV5wwBfLm?=
 =?us-ascii?Q?jsHhFSrOVn0KC/A75I69ISdh3EvBCcjpl+2zguGqmCGBWDNAZw5kp9078GmX?=
 =?us-ascii?Q?z2XUJy6w81beqnhHYRsuBmhAfXk7GC90Tt/Qx2aZKPQ5aZQ9O5RJdboVfMg5?=
 =?us-ascii?Q?ZDAo2m5fTsgMEPZ/y9fW3/L8ktu2WavhRABIJqNgTGhMOlIkwZV2X7OyWgjm?=
 =?us-ascii?Q?aVX92I9GdNIgvr3lmpGLkCjxVwgT+N460FHBxNHJje5m2SKWe9jfd81Kc0MQ?=
 =?us-ascii?Q?FaSwxLDmNpfldS6Qje0NUS6TSRgGp5WJj4Pp3fjt2WaylSwIQ985j+DF9KHu?=
 =?us-ascii?Q?COr9gUFEcZWHmVY8BDZFD9Q2Rqg3H5M5F+s60CEJtMmm7Q7Y5hw5COLoNmBQ?=
 =?us-ascii?Q?BbaVTFns93mTovwivIpPbiyx0IF7ys2cZThfrRvxnIrKRgljYksgYAHu7zbl?=
 =?us-ascii?Q?x7AyoDO+vYuD32Qh53oF0nglKUgygFXbqub/y+EZR44AMZFVkdkDhOkegZ97?=
 =?us-ascii?Q?IKj28gh3kBQk9itsdwAr9eOK+CxrFU0pdMsPCII1zSq6g8FksEZrR5Qr7OD7?=
 =?us-ascii?Q?KdFBQ4zU5Da6/uEGWIpEx26WCEHefwg6/YpNfC8R12n/gtU/DYlMvtXZJ6v0?=
 =?us-ascii?Q?Hm5rxuRC73Qf1zC070Mf15DGlyeejgHtJf7govrVwkz5+URDCu4KyhQb+yad?=
 =?us-ascii?Q?VfQARBUqxNDotr+mhIwxVQedWyVNGuUKVbUK/Fw3FX29oU2wOU3iyzChtyUQ?=
 =?us-ascii?Q?e+gZfx3SEqNDHm3Ul3QIm+p/z9YaqmVg+yyhxUCWtzDFRjfk9czl/IfpcadH?=
 =?us-ascii?Q?S3GL5QkkzpKW/EQMfkN6lURlvvXNw5vGSfVb2Saq6bjB57GHIPUxxOD++Js6?=
 =?us-ascii?Q?Wiar6h9pXrQVeVgGNgsZZxesqk9WqbQ0ab0h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QXt4dhue430rXGlMb1d57jMgldMdf1LWie/MI6x06uomfWJ0HND/cWV1k01L?=
 =?us-ascii?Q?A3jDE9gte9kxHPrI+U39Nd+XhkU+L/3f/OE/J2thT250qnp5RaV6nx5yrPjd?=
 =?us-ascii?Q?BpMNYKEqGNnmaLCgvV5q3b5CK2g0MYCM2ln+E0LP7G49PRU5mXJYM1d1jvaR?=
 =?us-ascii?Q?t6rVwc2i5GpeAMulGDiCHZJCBFXyTrEVt7X2ERe9YpXz7OrMzB/1q3DrM/qd?=
 =?us-ascii?Q?2loz1DqixcwQZS0EelsPhLTeII2fUIp+JwenVZzRB8AOQgD67R+L2YYRE0UO?=
 =?us-ascii?Q?POYiJKgqzBVo7p4mEGlZ20pbSs62ZBp7qvwK6aUrXgki5gMOwYNp+rIjZLNB?=
 =?us-ascii?Q?3Jfy9B0uBUdFb6qA9uIK8+6YqZ8FbJrO1E+5YCEnuajzmHqqLHeg7DWB1/Dx?=
 =?us-ascii?Q?CkMmHqqauri8MEMRt81WM1cH5ZhI6C2XR4wyEP2I0hfOijXtoBb/1p7u15su?=
 =?us-ascii?Q?YSlDkKnluKMeqSeGb39xGL0uAWKcvl/EshFVuFHH4XmqDVU66utcpxkULMaT?=
 =?us-ascii?Q?tv+H+5ZMW+Qifbz/NFOuX+ihXFczqrPl9Qn7NQ064L1SmKQRIlZHRwzRvGnB?=
 =?us-ascii?Q?fMj1dNYuf7JlYCoXvaprgoVt4Y3SzG+UIA3O2hrbVmfycIBz+b82mZeCbOEA?=
 =?us-ascii?Q?81DKI6QRFtxcHsE1h5U56k2RbuQVdmruy1JEfOxytlItU1UTVDu8utJnFSyG?=
 =?us-ascii?Q?xmMszouewMkhF/Q8ZcssxNOdoocvIATX+E7OCzQUHE8SPrquqyOU6xmSCyXa?=
 =?us-ascii?Q?GRf9hxPW5+J/5ICGBAPtSv8gsgIz1BBjEli+N4Ymq7aLWyCSTNr2jj4YWJBk?=
 =?us-ascii?Q?Nko2z+pwwWY59J6k63CBLwbp0x7ccVM3X44rAsPbcfJyKXNqHlVA+vGOR1ti?=
 =?us-ascii?Q?KkJPbIdUIlNr451QUPRS5EEmeZyCOjiL+lKujAGOz4kfjRyKRt0CfGJzCftU?=
 =?us-ascii?Q?JbnIjL4MUQhVlO+K0nzhZRKpvztaVuFXTOv62tnjma7jNiOpsyAcMQAibEoy?=
 =?us-ascii?Q?8qnIC8iyHgrKQkknPtSpD93Z5JU1iOwO0q4wOZK37jYRgVUY3A9zJRJxu/n0?=
 =?us-ascii?Q?RMa79BrtjtUlmSszxT525UN47VrmPzW4dxhFM4mvlqlWu9tvbDaFW94Y3ojx?=
 =?us-ascii?Q?8FvnYO+gygcnT2lUZB6hzS055ECiIDsusp0gLiM/4OYdx/GLKKEpIC2+s+nC?=
 =?us-ascii?Q?693JCqPU1g+n8gL5t8tWGsI6PIlZR75XmLOn9cNk62zCjCBd6ymcRpJSUcbV?=
 =?us-ascii?Q?OpWzwVhrHpXYXRNFYBBK9F+0oEnDkYsPowlTYK9n4fhPivH/Kx8yy3E0M/Fz?=
 =?us-ascii?Q?RKT1vB31hsJX+Tf0n6wILPdPiaGaj04JpA22t0L/5jCmJg65Lt7Xq1FdbvWa?=
 =?us-ascii?Q?1sV+mCXkpA4VJIqKqcQdERsrg2/FVB86EN+Oxjpvrp/Z/iuxLzkdN4a49Qnl?=
 =?us-ascii?Q?4CN7+ul7PfTStY1n8FyYMWyaKlORWKOnauwgHpBjtPdAw0aC/sJK1tE+qdCt?=
 =?us-ascii?Q?UkxG1mtUWrqnhhZAqTafX32sfjOBKTuEpE/iDyaYCLSfQtnb4z9Mf54ALydA?=
 =?us-ascii?Q?rEQnJMaITz5bt7xLU/Pz0r5VrW5dCsabQ/wYlw29IFBGYU0CiPIIrMcChwRQ?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b124dce8-0408-4fe3-9280-08de20f80bb1
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:58:05.5022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJBveqc09VJ+m+kwauFdTOL9/zXVyty97jjq7MDz4r3JpmixNrHjXMF1o8PhQ6Jb13NTddDwijxVrEEPVYuHhnLgeHKd3TVGqQqEXbrOyhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6166
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

On Tue, Nov 11 2025, Anshul Dalal <anshuld@ti.com> wrote:

>>  int part_get_type_by_name(const char *name)
>>  {
>>  	struct part_driver *drv =
>> @@ -322,12 +344,9 @@ int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
>>  			  struct disk_partition *info)
>>  {
>>  	struct part_driver *drv;
>> +	int ret = -ENOENT;
>>  
>>  	if (blk_enabled()) {
>> -		/* The common case is no UUID support */
>> -		disk_partition_clr_uuid(info);
>> -		disk_partition_clr_type_guid(info);
>> -
>>  		if (part_type == PART_TYPE_UNKNOWN) {
>>  			drv = part_driver_lookup_type(desc);
>>  		} else {
>> @@ -339,18 +358,16 @@ int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
>>  			      desc->part_type);
>>  			return -EPROTONOSUPPORT;
>>  		}
>> -		if (!drv->get_info) {
>> -			PRINTF("## Driver %s does not have the get_info() method\n",
>> -			       drv->name);
>> -			return -ENOSYS;
>> -		}
>> -		if (drv->get_info(desc, part, info) == 0) {
>> +
>> +		ret = part_driver_get_info(drv, desc, part, info);
>> +		if (ret && ret != -ENOSYS) {
>> +			ret = -ENOENT;
>
> Why are we overwriting the err code from part_driver_get_info here?

That's essentially what the code did originally (it only returned 0 in
case ->get_info returned 0, otherwise it fell through to the "return
-ENOENT" at the bottom). And it turns out that that behaviour is
expected by lots of tests; when I inadvertently changed that logic in v2
to actually propagate whatever error ->get_info returned, lots of tests
broke:

https://lore.kernel.org/u-boot/20251107201927.GA2243313@bill-the-cat/

And this is the only difference between v2 and v3, I tweaked this so it
would preserve that "either success or -ENOENT [or -ENOSYS]" behaviour.

Rasmus
