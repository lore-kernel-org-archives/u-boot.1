Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FADC36013
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 04:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1ABA806FC;
	Thu, 27 Mar 2025 05:24:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hubersuhner.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hubersuhner.com header.i=@hubersuhner.com header.b="Ui402MK/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A570480756; Wed, 26 Mar 2025 14:03:53 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7860806FC
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 14:03:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hubersuhner.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=amy.mclaughlin@hubersuhner.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPGyRnk5oLEN5rlts3KQhETT6XM9KxwKeLtEWxN2fCooUCgfqjZdPMYxKhr2wJ41ysY420RUyvwHWPhcDbEUjngmR39hfRb9ko482OmavIN1UEzhaW49dR1o0hLV1gVHoxZlmxI6qOeMuUIRPvGV+t6Kl6Cyl91+T+ZP4APn/iOJz86GDvMWQ9KAetVTICdDOyefA4l0MgEQQY25KKGtdDb4LHMHSgJ9/UFpVU8AvlskrYBHeXJA2i3B7gPceRbU0REq4RKhr93X6iUTOcIvKykP57xfHFRyA1M7cr6Dp9koH4v4cF6HrutivWRX2Lm7xeheShrRcNLEJK9Gmusz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6mOc4IBb3a763Ofl/FWwvb+U9k0FtkHaab3SwL41Qc=;
 b=Qxq9CdJiTBGkQCKZ5kAlq0vZ1gxuACk+VGUrIaUd3mgpE8CNNQVx23amD3IM0PyIphNUMbiJwhVjnx9ywwt4x/FpPWqzzFvr67j1YvxKtLFopr66KORr+MjAb1VUAD6Ohi9b0tcd2r29R0fYuUOWSbgrEkxchNCoz4Y4QWm0zmk5VDOUzom526zf9grjPY+q7uwkQlAZV4N/3NPFd60Lg2TiJPgmgo82oxUloFFD1JT9g6ioxqNaK34LZmktEBHn8wmUfQWfCryV/qdixsSlLMGQ0YrBxor6fLOBMq1B4S5o+eTrU2XH3xVIztkfEJfrJQU5JJIbziwM98L7Bble1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hubersuhner.com; dmarc=pass action=none
 header.from=hubersuhner.com; dkim=pass header.d=hubersuhner.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hubersuhner.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6mOc4IBb3a763Ofl/FWwvb+U9k0FtkHaab3SwL41Qc=;
 b=Ui402MK/2Rt4AkQKQYzbpqBwU3L0AhUnzqKmtEWUOThQ19hwu2YsQW/mtORc1WlKklDD52D/ftpAztJ86DBvMI449nfh7KVWt4vlkE4UzaGG7h9u90MOgZYDjcqMGylzX7S71N3yYPr6xYAh4U8o3NMdRuoc6nuCWl9lZdRVIVM=
Received: from DB8P193MB0710.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:156::23)
 by AM8P193MB0962.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1ec::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.25; Wed, 26 Mar
 2025 13:03:46 +0000
Received: from DB8P193MB0710.EURP193.PROD.OUTLOOK.COM
 ([fe80::fb9a:f764:7f57:e1a2]) by DB8P193MB0710.EURP193.PROD.OUTLOOK.COM
 ([fe80::fb9a:f764:7f57:e1a2%4]) with mapi id 15.20.8583.023; Wed, 26 Mar 2025
 13:03:46 +0000
From: McLaughlin Amy <amy.mclaughlin@hubersuhner.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: undefined reference to `__stack_chk_guard' when building with
 sandbox_defconfig
Thread-Topic: undefined reference to `__stack_chk_guard' when building with
 sandbox_defconfig
Thread-Index: AdueTwiZFwl2cWuzS4a003BH2MdK8w==
Date: Wed, 26 Mar 2025 13:03:46 +0000
Message-ID: <DB8P193MB0710CB597A4A1F3C5E1A0CE183A62@DB8P193MB0710.EURP193.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-codetwoprocessed: true
x-codetwo-clientsignature-inserted: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hubersuhner.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8P193MB0710:EE_|AM8P193MB0962:EE_
x-ms-office365-filtering-correlation-id: 74e33ea7-8b0c-41cd-6af7-08dd6c66a4ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xYnXN5ct3B9EdhRlYRJuz66Gvqs7lzzICPD7gjq4VCFAa7ijjx2MJhxpqGbO?=
 =?us-ascii?Q?FYgmJXpgfkwomHChp0wHw3vMU274hHW8kt8R5K++0ub1V9OFjbm5eiAO/1//?=
 =?us-ascii?Q?tyjxhgfH5IUixj7sPtM9heMua/SKlt10xxEUtMuyTrSqzOAaoZadLNubwoTT?=
 =?us-ascii?Q?Io4V/M76WfYxLVc0amqBncMYBsfcRCar/2Jjatgh2/njyvE+0638l8BSxMtK?=
 =?us-ascii?Q?gbcv3zWlSRGCjoJNQ9l6tuAI08UFkMvvhCsH6DTNVoEAQUk7HZ8UOywLx1wJ?=
 =?us-ascii?Q?iF0PEOyR4c1YeHFhtu5xN4O39DHuRhdhMnPfSQuZP+Wn232rw0iiIUza6AXH?=
 =?us-ascii?Q?G3kOUwCWq08oPyIqfptqqlrtlvyKhx4LYAXjz1wFSPRbuIZvZKQFYgxyqjJZ?=
 =?us-ascii?Q?9+DGUvRT+l9JoGLnF/7t6O0WtaocWSBjp2iFyLqi15Iz8JkZBWRwCqHwNk1m?=
 =?us-ascii?Q?vuTx5wbsiwW2U37jyVK4CoHggFIGcqhlAZyCB2XyefCTpijD2/Y0oLGyA3tC?=
 =?us-ascii?Q?1El6An72WfY0j2DgP5ZpYjefn/so91wSPgiZpb7UzFDRrdQ/HGBOU7BAFK3x?=
 =?us-ascii?Q?lhu6BrqQrNmnLojWtiIwnKvM3MIROAPApLI2Y5cLXOCMLeF6aVv/OTpDRN4E?=
 =?us-ascii?Q?ovlcWO0e0MLx0EH+bKbvKvsbxwKX2g7qX9kJvzBK+LAibkglfMDAa6bwHELP?=
 =?us-ascii?Q?dIEvLM7BibRur1kOK0DtezIdn/QN2dn+frwcq9iYvwd2WHeiEQJE5+MtiL2n?=
 =?us-ascii?Q?Wk97QKcdjUndxWKdhLi3RgT/EqgVqTEPE3CBLvO1Tdv3zdCm87TCyPUXcX7d?=
 =?us-ascii?Q?YS9ptUzfpoa/zWy2GLoQJvPwBo5wnJczOMHTTyP7pWlyPs6oKUG8hbgX8Ndi?=
 =?us-ascii?Q?APMJAyGo3xlRu12v/ZNwgirxsriSHrBvyoqEsyn3L6vzt6RjCcCwaa+6/+SR?=
 =?us-ascii?Q?mmpdDe5Phiu0cTA0ojxnuKcZhAuERghFMqnb2JYIdRt4i8OffQGn1qpNlhhp?=
 =?us-ascii?Q?U8NFmG1dHFaL8Dn+v9kmOPzOoQWUoQUU40QQ+KqPRbRL5OIM9lRmvbU6YQTc?=
 =?us-ascii?Q?gNvZn8Zka0qjtEzSLyy/EFJ+8Z1ZfKkJrsZwtXCs33Xkzy1pDHdUUQhdwxJB?=
 =?us-ascii?Q?9/OUWwGu/RO/SA4LFuyjyLs0lPA0L8Awu5b7wEow9saVt1FFMP3xvRGV8eYZ?=
 =?us-ascii?Q?0epjnNC5+o/IXVawEKPjaIaKwltFKyu+4RMOkPSTBL+EaU2zbferdTohF0MI?=
 =?us-ascii?Q?7yprB5tAkHva4HYAT2+5eOjbSQg8mmeIUt2LUHyAJL7dfc/KAi02uglWJUN6?=
 =?us-ascii?Q?U4p1fGBumNlHphpmJ4TWR/t8b0NCLMFw5lJgnjwwECmM65qhOx/qWP3l+nRN?=
 =?us-ascii?Q?bQtlu0VHy3BQ6Ax787crWWhPEFk5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8P193MB0710.EURP193.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TeUdGfcPEsqwIS5FcFIdNQwE7ULAWA65yU9/gp4hL2yx0nrRddc11O+Q+yKp?=
 =?us-ascii?Q?q3Tmk/wtUIsHumYX9iK/3Ye1KnGapNu0RD82RVZ8iYMSSo/RVF90wO99aigO?=
 =?us-ascii?Q?jxcJ3mQXqPsdcWEr7iITEsuegOdcI66xOkZmddw6xIL73xuUf5NjHIhTj16n?=
 =?us-ascii?Q?nr67sPSe4YpLhX9mlIEdbB534/n1PrZuitR80sMq70e7ehtiRSFdEn4VI+zI?=
 =?us-ascii?Q?h3rLciwwhpFYtMlvMo4GUD9l2u2gyQB3qqEJ5pjCM3kkeTYqMkQwmgj4XBEQ?=
 =?us-ascii?Q?bzhIz27okguEziL0g/XkYxohJ0u6Mf+7evPmaYnY/dbYhOnQuOlCtGkJDNz1?=
 =?us-ascii?Q?aZm8mCSk5eI15b8EGS5g3iV9YAlOTlmHoXmAJdCl8qHc5C0WX9iG2E4yVbQy?=
 =?us-ascii?Q?NUle32JPfrW9ekuqzd2BCfC5GH9Q0LQTQ42s3z0XCnoW12QxguQTxtnIVxg4?=
 =?us-ascii?Q?p4kwV2wfdB/8/t5wDWUO1Ju1f20inJG2VN/fycQVfYNCLdkOciYAMyhHcvCR?=
 =?us-ascii?Q?kgiP6OfO9qtun7rRyafdQMjABGL+KSyANkuJBjmcNNhXAeoldD8MM/VZYvtm?=
 =?us-ascii?Q?aBKL5YsD9EoPXZFjtYKvjXhba/pKUnRYwJz/R1AXa2tSMG/F3UMkpZmhAoj9?=
 =?us-ascii?Q?p4tQ+GlzONWBQYv47QxcUJAClOF6kTrF29LSedOPzHfcqrk+lJroST3AxSeA?=
 =?us-ascii?Q?V33L8y2odhOzVWYE0zS85wlQYbOc2GAy7EbrrFPORsPQvkH8LlVvQ32qV4XS?=
 =?us-ascii?Q?Nb1r2CXLeYTaJ6rYKIU9GVE+mAbY/UcNFdejL1huV6fDT39kVKe+HPr4FC4o?=
 =?us-ascii?Q?BG4ahnwYTD3cmomE1EpE2AzJlirmOoQWYQaHOCiER1ng0VhNZf1bLEVklNnO?=
 =?us-ascii?Q?9oJjL7hNOzPhb63RpN5Ct3oVSZeV0Zu6j6cccTKbosze6jZkOjRGKpu8AxjJ?=
 =?us-ascii?Q?YPpHh4GciPHH+tA54nBTUtZWNxhvZreohcAZ6U/nX+HCSHIatQOp26YS63dq?=
 =?us-ascii?Q?w53IvnJD3s37cyiGIHq6eNhi28NreKrEa9eLyo7u/V4hS51oa0BtOc/szXqV?=
 =?us-ascii?Q?ZhRJJ8aYfdqJ5rr5DFTDcwyD2+zcWOBj+OapOuMywu1DSOnQrD7ix6jBTwtB?=
 =?us-ascii?Q?UbgE0LJbH/cxQgchSaAywpVB0mPAl0pldIam5B5eTaMoLLSPdQLasgQwPYjj?=
 =?us-ascii?Q?6qOw9OicGYVXQ1ZCqglr/50GonSyGPBEEMShjmeKxRmTu5IV3myIJtbIbS6e?=
 =?us-ascii?Q?XJjOIQYCdXNI5vXVlssRc/MWLAkrjSCVmRgpsvTGulpA0bcDFmcnwpFxrytY?=
 =?us-ascii?Q?oagTgvxR753gtx3OWBrGfJfIOsxiuadaf0cRJendMrPzF002i1JNFXaZEmpO?=
 =?us-ascii?Q?eJgka0PyV/Q6wWxsKecZr9CtEtU/20VFdwTWWtlGKvCbX9rsx3wRpa5kVvRa?=
 =?us-ascii?Q?UdBnG1J3mR7hYxx0PO9GDETxtqDlwxVrIloPEK3lUTtDcvQKK0Nhbu9geLtn?=
 =?us-ascii?Q?YvV6QjByDCYDIqt65JT6jKS44fKHcq1mPexk9GwomiL5O+AqM3SFoIYaGVMG?=
 =?us-ascii?Q?1bkZz0idx9r+NBvZzFKjZVMW89fYf0WxuA2Ld8YBQlNs+NkOdYFI475rugIb?=
 =?us-ascii?Q?DQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hubersuhner.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P193MB0710.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e33ea7-8b0c-41cd-6af7-08dd6c66a4ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 13:03:46.5655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c6d8fe08-f565-4534-965a-95698574938a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uwlb5D+tH7t5QnwDTi+KWQBo+BQRT6f1SeaoJJgqM8wCyQwWf4m0O9f6B5JmaHdTYzFZuHdrJ0UCrVAXCCa8Y589abeYrLOrxyciNXaw7UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB0962
X-Mailman-Approved-At: Thu, 27 Mar 2025 05:24:27 +0100
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

At my workplace, I ran:

make distclean
make sandbox_defconfig
make all

The result:

  LTO     u-boot
/usr/bin/ld: /tmp/ccvKFEMH.ltrans0.ltrans.o: in function `pci_io_read':
/home/mclauam/gitclone/u-boot/arch/sandbox/lib/pci_io.c:52:(.text+0x3d1): u=
ndefined reference to `__stack_chk_guard'
/usr/bin/ld: /tmp/ccvKFEMH.ltrans0.ltrans.o: in function `get_token':
/home/mclauam/gitclone/u-boot/boot/pxe_utils.c:943:(.text+0x755): undefined=
 reference to `__stack_chk_guard'
/usr/bin/ld: /tmp/ccvKFEMH.ltrans0.ltrans.o: in function `parse_sliteral':
/home/mclauam/gitclone/u-boot/boot/pxe_utils.c:1010:(.text+0x898): undefine=
d reference to `__stack_chk_guard'
/usr/bin/ld: /tmp/ccvKFEMH.ltrans0.ltrans.o: in function `parse_integer':
/home/mclauam/gitclone/u-boot/boot/pxe_utils.c:1030:(.text+0x91a): undefine=
d reference to `__stack_chk_guard'
/usr/bin/ld: /tmp/ccvKFEMH.ltrans0.ltrans.o: in function `os_printf':
/home/mclauam/gitclone/u-boot/arch/sandbox/cpu/os.c:59:(.text+0xb3c): undef=
ined reference to `__stack_chk_guard'
/usr/bin/ld: /tmp/ccvKFEMH.ltrans0.ltrans.o:/home/mclauam/gitclone/u-boot/a=
rch/sandbox/cpu/start.c:203: more undefined references to `__stack_chk_guar=
d' follow
collect2: error: ld returned 1 exit status
make: *** [Makefile:1766: u-boot] Error 1

I can get past this by either:

1.) Commenting out the `KBUILD_CFLAGS +=3D $(call cc-option,-mstack-protect=
or-guard=3Dglobal)` lines in the makefile
Or
2.) Changing "global" to "tls" in these lines.

Apparently these lines were introduced in the following commit:

$ git show 4072572b0f8
commit 4072572b0f8aeffedcd908dc45b7e046ee0554b0
Author: Christophe Leroy <christophe.leroy@csgroup.eu>
Date:   Wed Nov 15 19:36:36 2023 +0100

    Fix stack-protector for powerpc
   =20
    On powerpc, stack protector expects a function called
    __stack_chk_fail_local() instead of __stack_chk_fail()
   =20
    And some versions of GCC for powerpc default to TLS canary
    instead of global canary, so always force GCC to use global
    canary with -mstack-protector-guard=3Dglobal

Is it possible that this change made with PowerPC in mind is problematic fo=
r other architectures? I don't know if the sandbox build I'm going for targ=
ets, say, an emulated CPU or if it targets the x86 CPU of the build machine=
. Or is it more likely that a local change somewhere by a colleague is caus=
ing this?

Supporting this theory, https://maskray.me/blog/2022-12-18-control-flow-int=
egrity states:

"The canary is stored either in a libc global variable (__stack_chk_guard) =
or a field in the thread
control block (e.g. %fs:40 on x86-64). Every architecture may have a prefer=
ence on the location. In
a glibc port, only one of -mstack-protector-guard=3Dglobal and -mstack-prot=
ector-guard=3Dtls is
supported (BZ #26817)."

Thanks for any help,

Amy McLaughlin

