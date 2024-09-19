Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96789CE8D4C
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 06:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83DAB889CA;
	Thu, 19 Sep 2024 08:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="g0Pbb3Uu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CDB38901A; Thu, 19 Sep 2024 08:53:36 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24E2A889CA
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 08:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/vw0zbjN2N+E5KNw2b1aiw1ZbhO2yT3Cqm+iLc8gsWsXp7gRNFC2qPAgVJkIYC8uGrzZNYyX6sps0IUfEF2dUk2pbEj+zLP4ppw+wEeke5DdSSkBZD/yNl3BAHyjQGkm9+qdHpbtGkF136tZjY/Na0WCDjVezFOfDfEiscjyv9JXswcaa308CYw8eeY8SppIwZ8HJIUjADTDvgxu5CXMoQ9q2p5Janwdr3RFxMT/h5BFuYr6pGvYOQ94kLkm5P05riBfzT9hNQLRP2PwCu91tbO/mcY6q7OcqWE7I3qeIovSXRcPiilbpQBoiHpO5/NOD/oiTUKnImj/bmMOkK4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixf2VdLo/UqHKs1A/sWxdDBMnF/6QXot3Pr/oMnnpjc=;
 b=dolusCYwzpmjdkRHmQbJExF2RzPMGMc1Br0F4JWEa501iT82PUv4KF4EpvY4vhDaQLfJUVZHk8UovgdHmbpKa8xn3qcDJewVPb+ch7MJ9QV9fy2a6pXJ5zv5ST5V8ivBGG19KQ2lCgSdXFlxD64meUg8VkD2MXFKV2t0kJ6xOcVikhsDXVYwBD5rJP2KGCZX/x0H0gTrpAYMhW5vJt05xWuo7HUpI2lMR1wGWgpMMXGm93gIvTPv1rscPOMKoEZgFiC17afUgRsk6sHMs1xKRSVm/WFd+SVPIdDhzsLU11Rg6Nlk1ZyEXOVQVScP12NDWGI5C2OzzKIWoRINYnMoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixf2VdLo/UqHKs1A/sWxdDBMnF/6QXot3Pr/oMnnpjc=;
 b=g0Pbb3Uu+bsU5RIPnz9ndgAcK6vfA9t6GnXObtPwpxd6Y9WvLWbhEUN5kT/CRQ/RaUXdMUh+5jjtHGlkI8NSE8sZ5e2sV9Xlqfp4YBmFfSla5NYTiSFfxrtNA6i+nhCg/RkFtWBNjzMZTYqFJA7xMz2+Pv0jZHb9jnlq8g3XsOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV2PR10MB7439.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:de::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 06:53:29 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%4]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 06:53:29 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de,  Tom Rini <trini@konsulko.com>,  Patrick Delaunay
 <patrick.delaunay@foss.st.com>,  Marek Vasut <marex@denx.de>,  Emil
 Kronborg <emil.kronborg@protonmail.com>
Subject: Re: [PATCH 1/3] env: mmc: refactor mmc_offset_try_partition()
In-Reply-To: <376f36e2-1fa4-4fea-9af9-2c2e491cedbd@cherry.de> (Quentin
 Schulz's message of "Wed, 18 Sep 2024 18:59:39 +0200")
References: <20240912134141.4143855-1-rasmus.villemoes@prevas.dk>
 <20240912134141.4143855-2-rasmus.villemoes@prevas.dk>
 <376f36e2-1fa4-4fea-9af9-2c2e491cedbd@cherry.de>
Date: Thu, 19 Sep 2024 08:53:29 +0200
Message-ID: <8734lwm8wm.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0009.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::24) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV2PR10MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 77579858-936c-4d84-a13e-08dcd877c489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4Rx1Xdtr/a6SFlLGuPDvww9a6gQ0NmT5I85lLDN1WAXcyYPjmDAd1mD/LTmR?=
 =?us-ascii?Q?Tz1J85WthotJWrXASqtBICvHCD7622EjM8Pnrn37n1j/PaCpVBbwnu4KAJ21?=
 =?us-ascii?Q?DHeWwObfYntvN1ohqvq3KZFFvRs6tpvSSYY7XSL+Q+PqznbThUvSZkrFb4RJ?=
 =?us-ascii?Q?/AovxU+fcHbiMaHP73CJljjlN8qND6VbIajWFpdWtv1R2ZZ28L7iu+Q9zJrR?=
 =?us-ascii?Q?kqbQSen/zPZvE3fEsdHSx6OsD0NFDdW0rgXToB5FwkzLdEdsSiXKRhcZd+55?=
 =?us-ascii?Q?AkJh7CxkUUNH+V8EqL/81M4VHy8SA2HNRS9GAZo+ZXSkaC/cgEzorOj3pEIk?=
 =?us-ascii?Q?swKgjo8NcA1cp1Fek2DTZBq64T1PGbMAeMV/2lm74q6CPBhzC0HC+6SJUxY9?=
 =?us-ascii?Q?KKzLeL8e1g6rEtjvttWUZ2RUYodoX57e26MwU77RWd4wbWXcQvAVnPdtb07r?=
 =?us-ascii?Q?t4gIuO+RdQE50GCargo0kTRnmfmv4qwis6FK4ZHqSaGEbXiBiEv0rwHp4IzX?=
 =?us-ascii?Q?ivIBlX+IjhkIht0hVFXTugThscakAvmENWSDRo/qCTCG1IiVF2if3ZsNZFtm?=
 =?us-ascii?Q?yitrUC22opB3PmheR1aTuhUxxZXMyvOOvlrcxnr9AUQDNbjGanShmPX/fI3I?=
 =?us-ascii?Q?v1gPgkcAcqWESUGVGX1F7l8HHyS0fJQOeBWMY5VYy2EBns0/PdCcFvZx+je4?=
 =?us-ascii?Q?GtEt9xYT3CUDEhfLV4W4+wax+xoLSYAZ3T2K0LtRd187OEIZBZf91vB13rnQ?=
 =?us-ascii?Q?8EOFPs2PzAEV+jznwQKQNpEvYuXkqlQMz/4LfJV918B8M/qVaxIHpMV8gt1S?=
 =?us-ascii?Q?byWybrDVQREtJ/ApKmxmtcuL1fg95n5uM9ddVGxOXsn9M0mb65bw5onoURDo?=
 =?us-ascii?Q?IUYOKsk7oIPGx3xl0aAujJXgYmR+iho68T4s3FOzrqXLWB767nTjYElti0Bz?=
 =?us-ascii?Q?z9Aov6sJokFjr8ITjxajHT/gyJtDq757wcmb1ZgDJ0/B8twl9t5nKgXbHkfc?=
 =?us-ascii?Q?V4/QI/4qnr1Gd8qbzTi5IdPuFioZow3AnsrvBZaWoabCrqYC/jtULenpE8Eb?=
 =?us-ascii?Q?qnj0UfU0+mZmTvK8rdjyEWW4tOOo2zetPtL7C6G0Q2MdZ2HPQGkmiHjebRoX?=
 =?us-ascii?Q?vQ10fpKR9mqcD6CdAu2KwoXrGNDMrvQV8XPUbrQCOP1dZ/tU+WEy+wavyglO?=
 =?us-ascii?Q?Cm+pTV/UZGq6ZSRZUBIUXFEZAiQsZBheYhhwU31j3Ptw++u1H4ZZP75J+gfJ?=
 =?us-ascii?Q?gw55mDxKHE3s9hSPjxtsHzd01cF1WMQsRrIxElgH1Nna2E1riuOdxLJhwqB2?=
 =?us-ascii?Q?LmPn6CKgLx56y3gbyqE5Aqv4zzzxmDod10prp6qszeClZtYzY9fNvsGGFppD?=
 =?us-ascii?Q?xACw88Nvc4q4bpWtlleAGk8vVgVVV3ngQebWsAWuk9O7N666Rw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WAV3mw8XEP0fXmzoDeeozZzmx5rF2iZ5xAGjeu5h3idOK8HXK+/wCoj3WpSv?=
 =?us-ascii?Q?jEDpiAhwmJVn7G5B1rBG+okrDUYAqqzr+itwHYucnOVakSublzExRJLCDquU?=
 =?us-ascii?Q?IeFAw+6WvDYERCgtTxZhHT8Mdnx7MtYlgA3aFsL8zNic6ukoFcxNC0u3SccE?=
 =?us-ascii?Q?NndOKlD06AeaL3W2fucB9WzCqmj2Q2pVM4u4qpcQblDR6mwymPMZovhoJ3N9?=
 =?us-ascii?Q?t36kVmdcy7kyIErge9JRZh31jJA8R7ShYDekDKWx2RlmGvebFlNcw8oQM62Q?=
 =?us-ascii?Q?8u0v+5MBnCzXmnINHTvkdvUFTt3aTaxpcQEBl+kRp/cWncL16F3NqQhW0W7E?=
 =?us-ascii?Q?zIhcbhKN2ragchg75+YrGQbL2HYocusq3Yc1aWG0A6S3isRylwEVFtI+f8rn?=
 =?us-ascii?Q?+ZWByfFMfeZjnDn4ncRH3PEu4hA6qsEij445aLdhANvScVEue4B3wI5ECqWt?=
 =?us-ascii?Q?ONfm4XzcV+uTBTyuxnW4iRJ5CkDlTNgvXpeVvkVPRG6/gppDQUiSx95oqi2u?=
 =?us-ascii?Q?SwWeYjtfzoXI7CcmwmNivRHj6KxgwHADT6GNVcEIMQFg2Zw4kEvNzF/1AdYR?=
 =?us-ascii?Q?wYomDWkKKQm+nQzkhFBTQmw5IzDg6o2staRmaych8/wzzIf3RtM2em8qCZym?=
 =?us-ascii?Q?U2vxWgD0TmYcALLWW639w/JWOx0brf3yj5azXdUXnPPyjcre07z4dTdhBCVj?=
 =?us-ascii?Q?zU5KXciU1HDv1yIPuGP5a6T64ojAKIHPsWPZEeoPLgQSzIEgH9wyZR3YgZxg?=
 =?us-ascii?Q?TocMBbDy+mDYVrp5hQ9UxrKOVlu04lsMRcSjEHj7/yfzzGKmn1SBxycPJCUc?=
 =?us-ascii?Q?IAnixMaWHoDrElb/vXlc3UeXtOKW5yp5tXQ30ma8CIK0OLRW8ouSVW0PPkxc?=
 =?us-ascii?Q?cYsKaEMendBDswcRwLnjk0j+Y+2cxUXwr5nr1GIpFqtRQdgq7IEza3akrKyE?=
 =?us-ascii?Q?CZjGHTsIRi5+EudhvxZspszxSjvEHmik3mad0iES5LpmQheD8eFZcB9N+zrj?=
 =?us-ascii?Q?6sJn9uNZjtEHX9BWbQxSCTUue8TK/YF3RZ4Ja/TkoWEdwyG4+PGxxz9jjPZX?=
 =?us-ascii?Q?WAKaK63j6GnHw3zEvT0NkYo9cCskQgXod+c13d6pb1naNpN6FHBjCNHphiM/?=
 =?us-ascii?Q?rW4HrnlkpN7IoRR9LtfczTEqFZnSgOcEoG7OyYiZbylQ+PH6E/9dV0ugBt7S?=
 =?us-ascii?Q?JThgoNLySYadEbVjPqEh6AES1NusAo9wr8R/28b/NN6B7579jcZZpCf5XpAK?=
 =?us-ascii?Q?nq/0uGUbTC6ts0PNG5NsRvoqQbWIz3IJs4q79NG7K31P0iZgJgbqat5qFdxX?=
 =?us-ascii?Q?NCqMiUDVIbvCyTpQRZDcAuWMhQR3DlH1hMO8bKJUp5bRUQOSmo4Ebl0Ix1Uw?=
 =?us-ascii?Q?93YrPrxtBIa2TVl6wUnXQkBLoqDbX/C4udBjd/PKiZxDVGGzyEdAfqwTPJd9?=
 =?us-ascii?Q?4lKk4FOoN1BsVzUjrTbr0mLDvwyU/91ZTLChjJeN6VlX5r7zSYxbUHnxm14o?=
 =?us-ascii?Q?pZV44oP0gyaMLb/taM2Z++kLkt53svmvQq/YwoHGrCSEfb3lh4fZ1N6aRWwY?=
 =?us-ascii?Q?zqJGnlIZxgmN3jCQiTOgtiq29PYWtasuuHnaEpqDz+Uzw3dg8QGBoR21W0xE?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 77579858-936c-4d84-a13e-08dcd877c489
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 06:53:29.1975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4V+DcOuI+pHX+eNLacOknTbUBSigBum01Xu2FfJC8gUQG505cj5F/j7EkrYc8sMU8JQrmOCT/y2Ktn25SQ9IFi2FqTA0riGV88euEMCRlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7439
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

Quentin Schulz <quentin.schulz@cherry.de> writes:

>>   -	for (i = 1;;i++) {
>> -		ret = part_get_info(desc, i, &info);
>> -		if (ret < 0)
>> -			return ret;
>> -
>> -		if (str && !strncmp((const char *)info.name, str, sizeof(info.name)))
>> -			break;
>> -#ifdef CONFIG_PARTITION_TYPE_GUID
>> -		if (!str) {
>> -			const efi_guid_t env_guid = PARTITION_U_BOOT_ENVIRONMENT;
>> -			efi_guid_t type_guid;
>> -
>> -			uuid_str_to_bin(info.type_guid, type_guid.b, UUID_STR_FORMAT_GUID);
>> -			if (!memcmp(&env_guid, &type_guid, sizeof(efi_guid_t)))
>> -				break;
>> -		}
>> -#endif
>> +	if (str) {
>> +		ret = mmc_env_partition_by_name(desc, str, &info);
>> +	} else if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID) && !str) {
>
> nitpick: it's guaranteed that !str if reaching the else if based on
> the condition of the above if condition.

Ah, yes of course. This was just because I tried to translate the
existing

  #ifdef CONFIG_PARTITION_TYPE_GUID
    if (!str)

logic as closely as possible. I can resend. However, I plan to send some
followup cleanups and simplifications to env/mmc.c anyway later, but
didn't want to entangle those with this bugfix, so perhaps it can be
done as part of that.

Rasmus
