Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30467F013F6
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 09:26:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8875D83FB6;
	Mon, 16 Mar 2026 10:26:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xe3LsGFc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 494D083FC6; Mon, 16 Mar 2026 10:26:06 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C3583FA6
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 10:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrtO4nfP8sYsKx57SIEbxeRelhtR6+uEJT2ufNIdbvnvowxvkqxeEfSrwTWkTGRxn8LtOoTqof3O8pQa0x+5rJ7iRL++Jwot0iSdAPo2bJc5tXqQIGDr0dRiAUnPf6qFaTXylaqSRDnIaITWJdrDlCx0Hzvib/2rPycj4PPE8U3jexFbVz8J9rdUVtNzpa3+LfxtFu6nhvzOXyAAseEn7pqkF6ZVbwdFV7766IG/wOkU+kgrevafJn8MrtHgpvD6rkpQgHZAXhRsn+PgSyBKfx28wq1B9ZwDaGznBvWLi6WQgqit/6fwuijnkTnvhskD+EmRwsjY237KhgX46k5IZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Olys2hUH+8bCagzNR60qYAO7KIcYKVZK8ZZoNs2aoU=;
 b=fbmZOdwA6zK4cy88jv97JQXFS41VdypO51Vm0o+mI6vCkVfEPLxiXbulRcsXwONw+rGcQRbjZ+exiy6T9oiKOqvHjhiJ+CGsheCGDNPIubaa7By8Ju/zeQY08VSzHbgi+5ilYlEkMVaMA7isygkyx2+CE/a/I88qXcHqxWhmSeplnvFHiRkk64bVHQavf7ertU9cl1SXsv4+qvMBe/kQ2FABn4q7UVnkC/FWFa8G68x3s4y8+vqwSsBDcLsi6vJRYF9UvldDlc0CqoTuEQcHGVW+rHnjIgGawHIS5tw5Q5NDaAw5HRd549o1KQigCE374nF/V5NEsqYdgqLaeSItgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Olys2hUH+8bCagzNR60qYAO7KIcYKVZK8ZZoNs2aoU=;
 b=xe3LsGFcmjIHrmRlm+CZELuT69Wo9/nvGRrAr38HmT/df8RhrO05faBFbLb929y4xamLTroSKe1oskqVY9J+PhtkOUrb7Osq9MOo9Z6OhGatAD+FARmMjYokvU0WShNwe004JHKo4ICLPcS3asZF6X1VWYZ+yD7Ga6cuBDZPmIw=
Received: from BY3PR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:217::6)
 by BN0PR10MB4870.namprd10.prod.outlook.com (2603:10b6:408:12a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 09:26:00 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::cf) by BY3PR04CA0001.outlook.office365.com
 (2603:10b6:a03:217::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 09:25:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 09:25:58 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 04:25:57 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 04:25:56 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 04:25:56 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62G9Pt5V552273;
 Mon, 16 Mar 2026 04:25:56 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Mar 2026 14:55:55 +0530
Message-ID: <DH43KJ2HRI9R.P2SKTW39LT0Q@ti.com>
CC: <u-boot@lists.denx.de>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Harald Seiler <hws@denx.de>, "Tom
 Rini" <trini@konsulko.com>
Subject: Re: command negation in modern hush parser
From: Anshul Dalal <anshuld@ti.com>
To: Rasmus Villemoes <ravi@prevas.dk>, Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <878qbyr2wg.fsf@prevas.dk> <DH0LLC5YYZBT.150TWGKWHGJIE@ti.com>
 <87h5qgp4iw.fsf@prevas.dk>
In-Reply-To: <87h5qgp4iw.fsf@prevas.dk>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|BN0PR10MB4870:EE_
X-MS-Office365-Filtering-Correlation-Id: ce58ca3f-0956-4f7e-ea9b-08de833e0884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: +9gJGplQeOAXA6HPeCeKgYxDanxUzac+/yT9ZuyLgsehNz+9AG5hRTFDQGWRjpAr2nZaLOGC97OsjNai+e429prKxLWIOBGrRQqn6SvzAeaOyziza0kf4bWV8QQhu+KR3QHPtMajkZjeWkpplc1ORFD3nDeXuNQX680INc18cHZQ6wrfz+iuVy+FakoQhJB7Grj0VLPpic0agju1vlPS0eELgXJPla/aIzMBu0hqWxagLxh/mmKgOsrwpC5xUnu2Ai7ZBYHL1tbu+wQ3jnWlty7Kt6+3gsL7Xmf1EvDHjKMfrsxmeHBJL8fO5gWXCH4BjfbXmGx9hsjy5d1LSKn7CuJwfCEuPCl2dVJw865mUi4Urp1BuFf3NAjjFrov3PZ91+O63pD7/n85vq74628gXXBwv6mtXlRDpsa9UBzgxmGOkO9KmfSDsstAxsMXkdDE/yKVMmxoewcoDJo4NjO7km9pN+veaytQtrU335RuYf7nZ+3Bq9h+WLSj+uEAFLAD0ISb+tdz03dNbxe+3FnB6B45lfbsKwnjc3lT1EBQo1KMc99og7FxX861zmfWbjeMtwHrRE5M3x89NjG38wxLPNmU0YDukZR81SWAZ79okTOkzr0BI9ZrqtO6yOKKIg8ylTRalMXKahmoqQAXV4mvjSfEpYEbBRnnwmgVkaf0aTQ4mdTpQk+z9Nlt9+FUvZIoZ3CDG1RF3AuH1Ta6FBlZ/gz8weTb9jpDR6uq2Nihlx/XQPMt7g7gO1wWw7Ci0vU8Dj3lluZa2zDY4miNQwq+cw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: stwRUcHHA0xChwlIYNH8lBgMefMLXAzjYWZyvV5c/VIjlDqtKJbOHTGMhIs+CIQB7F3vY+IyuDW0bqW5VK3XOIKo/+n+SeX/zHZtS5Rn/G3I90rwfVHHVRoK+SisM+tFaZt+trGG/JslMHEvSrtJPAaJNnaBRHEKuFqV3vEF7lSGZPCeOdNL0DEIRriTYndo0soLgp0xztE7GUCYbFJrHP54AZpqlmlWWlQ5JQGpiT8R+yt6mLItE/i9+af6nrOZ0lAx7k2N5XsQTc1veBxh0zMM7L9RH8MkeI6E41txweW6qteM10mrOOjSslNU2Hb1j2oWNvATSHnIeJM8qXtMijIQTFeOkKQT/ybC39y0PCopDE7F1JSAOPdUiv5Ih9qPXivXBB2zpCP8KnVtiJXE0kC55sjamJU7XbB6415qxY+MqwvA/a92e4ausEosHcV5
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:25:58.6013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce58ca3f-0956-4f7e-ea9b-08de833e0884
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4870
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

On Mon Mar 16, 2026 at 1:52 PM IST, Rasmus Villemoes wrote:
> On Thu, Mar 12 2026, Anshul Dalal <anshuld@ti.com> wrote:
>
>> On Wed Mar 11, 2026 at 5:31 PM IST, Rasmus Villemoes wrote:
>>>
>>> =3D> cli set modern
>>>
>>> =3D> ! false
>>> =3D> echo $?
>>> 1
>>> =3D> ! true
>>> =3D> echo $?
>>> 0
>>
>> I was able to reproduce the issue and it looks like we might have missed
>> reverting the return code based on pi->pi_inverted inside run_pipe in
>> the one of the cases. The following diff fixes the issue for me:
>>
>> 	diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
>> 	index 748ef60ac90..c01ba00e475 100644
>> 	--- a/common/cli_hush_upstream.c
>> 	+++ b/common/cli_hush_upstream.c
>> 	@@ -10377,6 +10377,7 @@ static NOINLINE int run_pipe(struct pipe *pi)
>> 		debug_printf_exec("run_pipe return -1 (%u children started)\n", pi->al=
ive_cmds);
>> 		return -1;
>> 	 #else /* __U_BOOT__ */
>> 	+       IF_HAS_KEYWORDS(if (pi->pi_inverted) rcode =3D !rcode;)
>> 		debug_printf_exec("run_pipe return %d\n", rcode);
>> 		return rcode;
>> 	 #endif /* __U_BOOT__ */
>
> Indeed, that seems to fix it, at least for the tests I could think of
> throwing at it.
>
> Will you send a proper patch?
>

Sure will do, thanks for validating the fix!

> Thanks,
> Rasmus

