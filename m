Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ABAC2BA18
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 19:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74999846B8;
	Sat, 16 Sep 2023 21:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="Wx29zCaH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC904854BD; Sat, 16 Sep 2023 21:37:06 +0200 (CEST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01acsn20808.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7010::808])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FC86833DE
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 21:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTjDm6eRmDH9xd35wzSLCPAYNXrD/MWs0Ro1OL7VscKzOoUmohrkKBcNCTzvkpLwJOBkLW23PjMMM5RCj6UgX+qoGRPXbepzVaXuqW4cRHVmAevvyICNFFYS2DV2IDxbeoIxYHWGq80W9EyIYXGcDsvf/C0DGcBW5K9riKOgo2n5pib18ZQlwUmpTp2J1MNEBEXCQjy6K3UrZQtbU8P2vkmj6zLqEV/ngtNRiD7sTpZ/Je/GJ6EdJ8DDPTt5DCA3IeCPuzc5Uj4haE2iOquXXS2zAEKT/FRtKzj+YJtHLRDdbWUpdFszlw1cp4+8p9lyarMg1c8Av2EVE9SyhT50vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loFRZufCrGh/EwyaZqq4rZB3W931zJY+Pd66bhERcPs=;
 b=nM9fmZNJhnvnZHx3dJprfzl+kNCUvDum2kHxZyRlzvA+iM/KWuRueqTTLnryHhhA2kmdro5FtOSxLAuzjCpfpz3YqJQf1duYg2EIq1xwr2SPBwZPoEML3XdwCHKdQILMRQty3CIaSinsT6wsmjMo3GiHbTikooAmzm7sloYh1dsiuCpCJFlkSdFU42a+z6ylcZiW7HBG1655oDkLfyJ4l/TmjRZdzSy4NQsamIXdjHHmdfl0dC9+8FsTLRGMkmdmoCuslgtiNuMCEYFNsiiwTaUJl7PIgoIdyc2V0lLmJJCsu1LIBQF2OWeCH0vY4gm1AH6+Zzj4vj/sznF8iTpq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loFRZufCrGh/EwyaZqq4rZB3W931zJY+Pd66bhERcPs=;
 b=Wx29zCaH2sl1U5sD1N2bSA7Ss4QSCgi48d01nocLjK6dC7aYmm1WC6sqPHWVVphAhsbfYEn8FYrXEJQc/YrTFaXVTKMvdOq4qZS9ch6Xk2TBOtIU0jOgDZx523hgY3bJMLMoI0kdcyJieHciJOSsY/nRD5MjaCytJYRv/vmIWrHEoCC4dX4lmROvmv8ebFZI4cL99nSgexEgQq+lQfyEDs2zKaQKp8GURgXQGugRXEY85jHcTotV2Lopf4Vub1RXavkOP8hFlZLQXmZ55s0hugJHJQub5bL9ag5J5MgQJ0cK6uN5JO2eSo2qQUs4K1XhdyN9Su4HVk+1f+RwHXlXNQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYCP286MB3132.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:293::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.13; Sat, 16 Sep
 2023 19:36:59 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b%7]) with mapi id 15.20.6813.013; Sat, 16 Sep 2023
 19:36:59 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: rick@andestech.com, ycliang@andestech.com, yanhong.wang@starfivetech.com,
 u-boot@lists.denx.de, jamipkettunen@gmail.com
Cc: mps@arvanta.net,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 0/2] Fix memory size problem on Visionfive 2
Date: Sun, 17 Sep 2023 03:36:31 +0800
Message-ID: <TY3P286MB2611C04E3893A31204D9EFB598F5A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.42.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN: [YgMiLodmKTSI200Ea9kGyjcuU68S6j6x]
X-ClientProxiedBy: PS2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:300:41::19) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230916193633.3928-1-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB3132:EE_
X-MS-Office365-Filtering-Correlation-Id: 51203ccd-073a-4301-533a-08dbb6ec4a24
X-MS-Exchange-SLBlob-MailProps: a+H6FLLcF3rrVmitAocszJPF8ZsL7sNyftC3iMW4wwD0Q6hJFe3QS/DJZn0Mty55ooPLDq727Xx0VWgJs3LuTUNzaXYBJ54d0gDfGB+52EQ3aeY/RL0HXyj3kFDq5BVJdTAOYIm0s5/93NQl45uhJUEUu6ft3DDYZp6LoBQg9O6U+3N32Pm4PP2Ewq/N642TZ478yq2NwNkvYb78WEMsdMiZb+EwKVj1UQGeinKjjAeapCWlJib1XrflDggi6VCwwMARR9XPJBIMCD02YxxByXrFbavlJdy64SuZ9blEmNsrxtvnx+hfG0TdagMkTAJ1A98r5BfcfoyX6TXGuey7zC5o5qFuMZ/tJSFEaUNATJv8D87sOoulqAVg7NckLrjqxSehWijk2IbjgWLKZF1At2mmoa51ICKvPfmi3CAGV9+zJWvZxCs/EGze7XuuED/sV84y8n4wXWRNMP4TD7vK2mATipRUEu2Jx+QElaDjLnW27+AtQYElLdlFnkHT5ZqEeWQN05klYo+bql44bdgcqvu4CADEJgFmrhCJXqI3NIIkZied4cszhtNyAnVg7Znm2Y1DNuAoOvVrMU072V6M9ugytt3nmJ692TX9CGeikikXPhXZBO2+51GoXJn7KYYVm4XuVe0kJsOlQesPtLveTw3bKsSpDvFZE4eLjyGl5yKhhEx8y/xf1kNUT+SttXi2KqqhivKzKuK+/E3KGDbbacRt5BYfM2fDeELLab8yf15FOjfP/rKYoOdi+aV1dVZYuVsGHzabFxhclCfgCdZAwH5+2UeX9CQYSfzDeDcAMPg4mfErV3dIR7rGm6SnlD8x
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CG/vbH6mb0AumbSDzNUvyxEhw3g9SHsFJ0RqCdJPhHhKfNzGVCZ6d2dyOkcP8ftyhWz2ZPtClWmjeQXuvV7OMu6/bdEOHvzM1B3oJrcuP1z8Y90QPMkB6RBhFaK+d62V2wC9FE9Nmrzrm/hvaEdeP5J56jeoDkrdFnbPanBpp1m6vq/xwz+jbaa81MVI2y24hoWHOjKmEQJRHVN+gGzSMjXPrrjKrrAjJp+wnRdPJSJZUbsdhHzXkJ6eU4zXAgY2utd0bjC4yMxYQHtkl6iXQpFEK5ZOQK9DG0JPJHVRk9KXv5JiGNz6bqYBjihFClF3CiU9xbBSjLPJ3MjUXC4CP/g79TdMeL11grTQO+tf7AI92ovqhgdX0MXwBNUyNaCTZKiNK4X0huDMxZ7xf6tVRJ7YlBWrzsgIUh/kseDfzloTHN9qti4D+FGeupyZ32vGI8U36Ux+mj+R83qRWUs72O+0tlftmW6mICt2di2Zqcm/qYhsOrjMeByZYgm4jEAQrEU1MUpNoX98gYoN4gcYzcE2hULhlzKJ1a9DGs6ct+crl+e4xww4S7P1IUhMrOM1MDJMVT9is94XHMmRofgn8MIsLqV8vQ74YWd2pOXkxQsaVkqID2ElVdimLzJFox1U
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUJvRjNxYnVFcEoyQXNFbnBEdGNCWGY3eFpQR0toV240cTJJNjBoNVA0eHp4?=
 =?utf-8?B?SmJYM1o5USs1c2VWTy94NmhDZ2hORGRMbDMxdEdrQlphcDFrLzMzM1I2Ung4?=
 =?utf-8?B?cVQvSm9UWjl3NVlYWGU2TFFIb2poZlh5S1NCL1lGL3h4WU9zS0RyOUl1dUc3?=
 =?utf-8?B?VG1LZ2JheUo5Y3JVc0xqTjVGQnZwVmZvWU1TQUFPbFpXZVYrb3hlc3kvL0hZ?=
 =?utf-8?B?N2tpeHZzUzdjcVZlQ0hkNXRGOERQNHNYR0EwVnFqekxJWUhkSXppVE1EMXMz?=
 =?utf-8?B?L0NsNXV4dXVIWTFyVjdLdnpta2I1WDNNQjBJUGdQZjFOeUh6THNWdjY5WHZM?=
 =?utf-8?B?UU0reE0zTTMyWHVoOS9pNzV5TThoY0tBVWtxalVjaGtYZkVpdG1pdytFMmxF?=
 =?utf-8?B?RkFqZE9PZ2tTMUZoQVBvMVdqS0hrVDhsTytyYk10YVZOZUVBN2lHelpEcVVX?=
 =?utf-8?B?b3BrWEhTc2NIVUIwMCtNRk1TKytBdFArb1hWTHd0ejJSTm1HaXZuMjBxb3o4?=
 =?utf-8?B?TkVwTmx4OGpKYWVzRkVuYUsxQStYd3RzYmNTU2ZTdXFHVG1UT1VwekFtSng5?=
 =?utf-8?B?a0VCVDBLcktNMHdpYjJ0S29yTThUL3lISU5FSnpuZkNEd0NVMFNuRndYTi9J?=
 =?utf-8?B?d2RWYzFHM2dSWkNNbGk4cjVTRmp2dU5ramJYSkwvRVF5V3U4cmZ5c1pkTkZD?=
 =?utf-8?B?SG5QTy9CbW4vaVE3WVViOHg1ZEtvSU5wL0wyeSswSXpZVE1NUU5CNDFmWFdB?=
 =?utf-8?B?THE0S1c3aGpXcUlJdkVWWVUvUVZQZ05neXNPbGtsWGlHelNwQ2xSRklNUlor?=
 =?utf-8?B?cFlPS1k5KzE2Wi85d3NhTklOcmdGcFkvcWZ6eWExL0pRT1phOFJiZUFIdldJ?=
 =?utf-8?B?N1UxdVhPZEZhYWxhcVRrckw3cFdGME5iY1hWWTNKTlVkNUVWQ0tnRFlodjFY?=
 =?utf-8?B?OXZMVXhld3ZiQTQwZUMzVEFkMkIvWXd5Q3JMTFJ6TG9yS1RtUm9LTnVGQ0k3?=
 =?utf-8?B?T0k3WHZMMmVNK1djQ0F4dE05c0R0ZVl5b0pMWFNDdVVieHhYSzNya2lRK1N4?=
 =?utf-8?B?bHFGVlpnRDAvQWRrTWpOdENBNDNJdEdDT2V4WWhadzFSVFQveFlBWHhuWW1T?=
 =?utf-8?B?T3FFRC9peGJlS3lacE9VdFpjNVMySmtZS0ZTMk5NbmgrL3RGSmtveGxyT0FS?=
 =?utf-8?B?SzkzRktuOFI1OGRRTzN3TjRUcFdBdGpONytrWG0xeFpKOTBLQnNwbzBMcXhl?=
 =?utf-8?B?cjFHSmlKb24wc0RXYzFXa1pGWExCT3lKRWhyeDIySXNNbklwQzlueFpiNFZ2?=
 =?utf-8?B?ZjU3NGZQZXlHUTVTWEwvRG1FRjZyRzQvNHhYQ3J5ODd2Yk84WE1kbUFJTG5x?=
 =?utf-8?B?QjhUWVdMSi9yU3RFMDExc1V2RTF6VVBiQ1BQTFE2MGExelkrYStiNDE3SCtw?=
 =?utf-8?B?RWE1VnFkdmlGR3Y1MStPV0M4S1YzejNQODZ1enoyYjU5MTNoZGNjWUJKMDIx?=
 =?utf-8?B?dUR4YVRpeDlHbzMzTGE2cDl0OU1Rc3BVUnVQd3dlcktQWmJrYmZCNGVpZ0Q5?=
 =?utf-8?B?Rmc3aEp4aWhxS0pCUCtxSEVESzc1Y1FwM2VwU0sxRG15amwwMno4bGRJRW12?=
 =?utf-8?B?VGpLeHFyZGpSekNaTkt2VXRRaXFFUkE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51203ccd-073a-4301-533a-08dbb6ec4a24
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 19:36:59.1160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3132
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

Currently, we pass u-boot device tree to kernel on Starfive Visionfive 2
, and this is wrong since u-boot dts is not sync with Linux for this
board. Jami's patch[1] fixes this problem, but we are still sending
unmodified version to kernel that doesn't have a correct memory size
info. This series are based on Jami's work and provide a fix for that.

[1] https://patchwork.ozlabs.org/project/uboot/cover/20230911153253.20701-1-jamipkettunen@gmail.com/

Shengyu Qu (2):
  configs: visionfive2: Enable CONFIG_OF_BOARD_SETUP
  board: visionfive2: Fixup memory size passed to kernel

 board/starfive/visionfive2/starfive_visionfive2.c | 7 +++++++
 configs/starfive_visionfive2_defconfig            | 1 +
 2 files changed, 8 insertions(+)

-- 
2.42.0

