Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFC9C624CE
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 02:40:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5BE880B4C;
	Tue,  1 Sep 2026 02:40:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Ep62jki_9C1; Tue,  1 Sep 2026 02:40:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788230410;
	bh=kjd8D+NQssDmLG8c8/U5B5SRMvC32jCMaN/APunT/04=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lUd+JjEF99HmZMAT284fbi6c5uglPVvDb6V+Sxh4KtKgj9cN5VyXSSJm5nzjmyFAg
	 xX7ZsJ2W3hDPv/bFDeEr0dJrKJrH3c2Z/u0dACzK+QhO3VW1C4dsKx6r859mFhUU71
	 r6KyyZa8F/+eguqzYxSG9hgjSWXtsTzVvond6RPyFd49nQZD30A9fYcdkI81JIx0mW
	 BJshgeUpK1Mz2yP9uTCorMBza+NlyP7PrzM5ztNcZP65QWLOsctyorXJga2FgcQG72
	 Kz5KHIja5yeaYvmYJaTUUPPIAtfhkK+OsBaCZAFWm990wAqA8A1Z3kBEdZDvR+hjir
	 6uJADPYZpFW9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F32680B22;
	Tue,  1 Sep 2026 02:40:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6645DF2
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 01:04:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4C40D60603
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 01:04:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lk6ZkDCeXPYZ for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 01:04:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c000::1;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=hibrian827@gatech.edu; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=gatech.edu
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gatech.edu header.i=@gatech.edu header.a=rsa-sha256
 header.s=selector2 header.b=q6qAZcTv
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 814E5605E8
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 01:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FW0iHy1F5H750jBjBE0d46uh+HQIPnJ9BmA9ledmC809iyNLurXOIn5zZQmCRzfFxIjyHIBptCAfQOCbQQFgThhKv7P/rWGRn4tjxPixVV3z0D2JudmOyIJv/bmRbsmII++TAtZRHpNT2RlZ6T0A1f+C+qfIp9nrGZFFKpRcTV+VVLZaKY2zApeCGjLoDVQN/N3uiY0sGBKR4VLvbSM0aLG/zO+R3XJOtipcSoQvHLvIEYqYJrX/1BHwjOrul3T5TFJ3EdsjGA6mbZbTRGeeBd0+PHIS19SsfTt9BvautQud4mqwdhE86j4tjLrOgYGGEqtdoZCyvGKyidMOrRBaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjd8D+NQssDmLG8c8/U5B5SRMvC32jCMaN/APunT/04=;
 b=rCO/ZuUlxriwtLgCC6QqzEZD/VdOZOyrsqpCILsBrO5bEIUk0/pgjanzd4hFwUF0mNxvwOk344GqkzsN7tfrRuCFahmIT6cv6+ex6wjaar/O59f/JjU80/yGRdYEQgpn++B6ripdXp/+y25P4P6Y3pIPYG3zqy7bkgEv4v1kQWAC/JGPsbD+clwItU99oBpeSLaLaaESVem6PQYGnafTxOhNwJImMWDGfX7L8wwu9/D0CNEbap2qU6SX6G0ELb9WC6jMwZRE88xKtIpELEg82jJD7yupfeNlp0A7oKFUx0EgjxFYI9cOpc3C/1Vz+qqzxFiaIY3z1Upk79PyT2vvlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gatech.edu; dmarc=pass action=none header.from=gatech.edu;
 dkim=pass header.d=gatech.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gatech.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjd8D+NQssDmLG8c8/U5B5SRMvC32jCMaN/APunT/04=;
 b=q6qAZcTvVC7lRbGA8kj3zj6OzeTelRwHfOex8Yh1wsqIM9gT3PYyq+QmldegbVdq4jtGTnuTOiyzqvYzaaz8Pd9IA6V/zNw4H2T6vTjO+U8ATdTV1gOUMANJxErgaH01WsXw5Ojbk0Hqg7yPeYNHXwjn/92QsI7K3uc/K60Wspfctf1BjfNC2ess/MaEze3NZIY/NApiNUYUy0sS2lMaST7Lr9diSjrvTSAEdStCeWbRPlGzsDGCEFz7kq+E4PW53OxUai35vbw2DBfSEyqz+avapO0Pta8SNbnIhMhfpLSEjzuf9Z9fFaPzG+mTCiVniuEu8mixM97RuF0e8w1yOA==
Received: from DM6PR07MB4377.namprd07.prod.outlook.com (2603:10b6:5:bf::19) by
 LV0PR07MB995468.namprd07.prod.outlook.com (2603:10b6:408:408::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 01:04:11 +0000
Received: from DM6PR07MB4377.namprd07.prod.outlook.com
 ([fe80::3bd2:fc9d:167d:e059]) by DM6PR07MB4377.namprd07.prod.outlook.com
 ([fe80::3bd2:fc9d:167d:e059%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 01:04:11 +0000
From: "Lee, Brian J" <hibrian827@gatech.edu>
To: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
CC: "Kim, Youngjoon" <ykim3186@gatech.edu>
Subject: U-Boot USB host trusts advertised interface count after parsing fewer
 interfaces
Thread-Topic: U-Boot USB host trusts advertised interface count after parsing
 fewer interfaces
Thread-Index: AQHdOatG+NKO6zg/nEu4Thbqg18u5g==
Date: Tue, 1 Sep 2026 01:04:11 +0000
Message-ID: <DM6PR07MB43775BFF4B099B0F3988BA78F6A82@DM6PR07MB4377.namprd07.prod.outlook.com>
Accept-Language: en-US, ko-KR
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gatech.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR07MB4377:EE_|LV0PR07MB995468:EE_
x-ms-office365-filtering-correlation-id: 6c63e934-b370-4db4-35ed-08df07c4eee5
x-gt-tenant: 042d12d7-75fe-4547-b5b6-0573f80f829d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|6049299003|1800799024|786006|38070700021|4053099003|6133799003|56012099006|10067099003|11063799006|8096899003|18002099003;
x-microsoft-antispam-message-info: sEhKBM8d+MEQHhgjA84qZJLgP46pg1CGb/QIhh/BjIdCjK58Er/RlCZk7RwxhsolqS6a3o2Xsvpy27pkyzWNMIlQeAHP61p1+x1aalIXGorzTZaliBGUO60b9savYjja0RDGDOk1RDcDYfeeWgB3kNjpeCZbJOcMZaiMxjOJVf8T99sYbAXM5pPpz25tjLJnEw6z/vzMkSLBu34Z0TCcnnQKhXLkAstQAcYX2HGQpCYU5DLF4oncnBwNKLHHqZ49py5nah00klk3CMpf0ueawmT8kv4hUxGDKPw7d7U6PYvg3DQLZdl6FRDKLyUmfom+TDmJiOsUmUdaK6ZrfSo/whyQIIKNIyu/NvGEAyKTU53zKm5m+TzKmkQ3Bn15obJADdUJ3FPhj1yCN5ZAQRs4iyfBOChEOld80+0wdbvCNnvt8Q4aFtDgcs5tykrxr5Nft6Rae1+xFxJAPV3+pD+qil84CU3Lq2Xj59wrqbIChMed+DU+/AYPr7qVpVXBLmcnDxOmY2v8BINfj3UyVdN/WrPlHzP65+z0pWLmv/9tJ54EpLS159KqRFR8RhKZy9nCmvnRs+L24Ozx7yW1w8bgTDygTxq/o7hmNzzr9nmwIuk0Zz6VujcOmZV5yrDhLwTKZ4ikpwservWK/DhO/TncE7T3JHNImxWjJZdI7CTLltQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR07MB4377.namprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(6049299003)(1800799024)(786006)(38070700021)(4053099003)(6133799003)(56012099006)(10067099003)(11063799006)(8096899003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CPZB7qMoxstFFSWOeYS6NwPokxWfOQuX6BmBSGorMsPt1axWwbiVDwO5MX?=
 =?iso-8859-1?Q?j8Kom3DAuHamsMZtJlHEvoY5mkvYwpp8Paq/YRUya7R2yOTx8D2XDfcpwi?=
 =?iso-8859-1?Q?QdvqU3a6vA7k4Zzorewf71Xsbe8kAOW7sazLg07j1TUzlT7kk6ZDybrcMS?=
 =?iso-8859-1?Q?EiVh8r9U+4476owdRKPS58ey6731BVypBEMVkU5M0e8jmD3+TEWq6k5cgc?=
 =?iso-8859-1?Q?vIznJtdJaEG0JgK+EVjuaRoQEiNjsguKmUVrmdCQTBkO9vqxb45RGzzXcv?=
 =?iso-8859-1?Q?gKHak5g2cZTxxl+WpL93lvIdl1Zd0ELyVxb13INfN87tY+0zY934hSI8Q0?=
 =?iso-8859-1?Q?F7o2cq5vY5zmQ4Y5bJTtOtlqThgPxOr9nYav99+kqYel59UGKO/5w3dqJ+?=
 =?iso-8859-1?Q?LG0P3/hyhOC7wdeVWXPBUflDSP4HIGw06PJRLbPM2OdtrZzjvzyi7S9w50?=
 =?iso-8859-1?Q?x6+3CyV1CqVA+3K51SVhTOtKF5FGMc7IdPbymvk2N85wfi3g3N2e6nguwx?=
 =?iso-8859-1?Q?M31Dlu3JF3mJbgJfraI0KqCsmYfDHt/INW59FbUPMpn1WhbOq1YtrXMC94?=
 =?iso-8859-1?Q?6cM11stcTfnkzIX8ZWXO8jdYGdOio+Tinuf8AJD7YUCIoiiqAXHDrJkc9C?=
 =?iso-8859-1?Q?gn8bGhwlqgDoOCHmN2utsDVnhC6N29203Tg6VyJ929EH0/5Ok5sjy8sKgG?=
 =?iso-8859-1?Q?ZO9mfC35TAVZMbgVxWjDryAZOe2ipMITC4Rrr3FHe94XICrg2nyD5y9kJ0?=
 =?iso-8859-1?Q?KPVF3ZzmNGEVlWBmm3QuHhpWRBTvFK6qrwJLmCuwvY5UdJk2v8kDiGQ7xy?=
 =?iso-8859-1?Q?3tToJYLFnfbzhS23H7s3+3fvxA8sHBNm97OpkBta1lEo87KeVFH0xK1xmw?=
 =?iso-8859-1?Q?CfZm2oj+ZArjdloBXfnSR6hWFz4xmEJQ3cSEj9qsacqfgB/qp7j5Lag3/g?=
 =?iso-8859-1?Q?zoRzf/vI+lorOmA2WFy1aoVyR3pSVBgaYC2wBwzgixvZvAlynX5lj7H2Ow?=
 =?iso-8859-1?Q?YBeMD4L2OLEGTvG8gpErS8K+o6stqe8ei2D/VgzhaPnQg8IN7KEwmYA9v1?=
 =?iso-8859-1?Q?80LaPeRPrS+BpbgPief/6UsvesoZlmCC0EjssAlUviVpBA4M6kOuoMYeOY?=
 =?iso-8859-1?Q?KEbRuRNdkdZyuYsiAlUPnQxZItBFCGp7F83E5mzkPp9VO5IZWU1om8UVNG?=
 =?iso-8859-1?Q?JUau92m+WR35geC2I5L4tcoD8qgIwKnTqlCfM6BG/oxWBTFaqxpCYXcpav?=
 =?iso-8859-1?Q?iVfrmBz8awwrtPSdmJaRRLfTEZVVCq0IPf7tDnsrDK6sNlL1iaNRhNg5p9?=
 =?iso-8859-1?Q?4vW9nP1eV1x/PV5mUX03F/oUWslzlhXeCA1ANiNshuAHae9nF1Mgws+7he?=
 =?iso-8859-1?Q?A9zeWo4PuJePpMaXvk64u+cxwm9XlHmSW8m1cfq4cBLLxRbLzwZ9cTrMgs?=
 =?iso-8859-1?Q?74hJY0BCxvRIYGHrzMbEW6ui9TnCxBeTKoLgyYe7BQg3uHk2m8HEKKNxQu?=
 =?iso-8859-1?Q?hv0kG56E5SxAU7qWJWXc4zJo0wZ1Cwhq/YjzSIjcUXiwtNGKTjOHxqqM0y?=
 =?iso-8859-1?Q?MiCo0YW18SHO0i8YeMqoltuub6+EWDEm6BfHl47V4tnN4gV5DRgBA7i+v5?=
 =?iso-8859-1?Q?3NRWsTgwcnfbFj10pW+Z+OEpf52kwNAbcH2/g2rqsgTpJNAFalKame2xKg?=
 =?iso-8859-1?Q?dycVeI0JO40bZdZmrcN6xc1/w53vB69uNkvrnYzLKQfea37am64o2ltb+i?=
 =?iso-8859-1?Q?YMqsL3Wk2dB5J8ViYLI/9oVkd4cI65l5dbVYp7I2RekKGr?=
Content-Type: multipart/mixed;
 boundary="_005_DM6PR07MB43775BFF4B099B0F3988BA78F6A82DM6PR07MB4377namp_"
MIME-Version: 1.0
X-OriginatorOrg: gatech.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB4377.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c63e934-b370-4db4-35ed-08df07c4eee5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 01:04:11.2497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 482198bb-ae7b-4b25-8b7a-6d7f32faa083
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pFDC1jb6ZYQSWBXxqxU1ReSaxfMalMBmlq4d4fSOvc0z19udBoQHepfQC0XfIm7MJIeV4AFCwhCmh4HEHwKeZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR07MB995468
X-Mailman-Approved-At: Tue, 01 Sep 2026 02:40:09 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

--_005_DM6PR07MB43775BFF4B099B0F3988BA78F6A82DM6PR07MB4377namp_
Content-Type: multipart/alternative;
	boundary="_000_DM6PR07MB43775BFF4B099B0F3988BA78F6A82DM6PR07MB4377namp_"

--_000_DM6PR07MB43775BFF4B099B0F3988BA78F6A82DM6PR07MB4377namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

My name is Brian Lee, and I am a PhD Security Researcher in SSLab at Georgi=
a Tech. I'd like to privately report a potential security bug in u-boot whe=
re U-Boot USB configuration parsing retains unvalidated interface and endpo=
int counts, which usb_set_maxpacket() later uses to walk beyond fixed descr=
iptor arrays. We found the same pattern in 2 different nesting level.

Target:

  *
Project: u-boot
  *
Repo: https://github.com/u-boot/u-boot
  *
Pinned ref: 3cdce049f90d77c3f9221f1eb73922384c8972c3


Bug 1:
A physically present attacker plugs in a malicious USB peripheral that answ=
ers U-Boot's standard GET_DESCRIPTOR requests. The device returns a valid d=
evice descriptor and then a minimal configuration descriptor with wTotalLen=
gth=3D9 and bNumInterfaces=3D255 but no interface descriptors. U-Boot copie=
s the advertised interface count, records zero actually parsed interfaces, =
ignores the parser return value, and then walks dev->config.if_desc as if 2=
55 interface records existed, producing an out-of-bounds read during bootlo=
ader enumeration before an OS or higher-level USB policy can intervene.

Bug2:
The attacker connects a malicious USB peripheral to the target board before=
 or during boot. During normal U-Boot USB host enumeration, the device retu=
rns a valid configuration descriptor containing one interface that claims 2=
55 endpoints while the descriptor body contains exactly 16 endpoint descrip=
tors. U-Boot copies the interface descriptor, copies the 16 endpoint descri=
ptors, then uses the unbounded claimed endpoint count to walk beyond the fi=
xed endpoint array while setting max-packet state.

Attached:
When reporting by email, for better readability of the email and for those =
who prefer private channels when discussing security bugs, we share the ful=
l writeup and PoC files via zip file attachment. If you don't want to downl=
oad an arbitrary zip file and use it, please let us know. The zip file cont=
ains:

  *
README.md : full writeup.
  *
poc : the relevant files and scripts for reproducing the PoC

I would like to get help from your expertise to clarify whether this is a v=
alid security threat or not. Thank you.

Best Regards,
Brian Lee


--_000_DM6PR07MB43775BFF4B099B0F3988BA78F6A82DM6PR07MB4377namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
line-height: 1.25; background-color: white; margin: 0px; min-height: 32px; =
font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: black;">
Hello,</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
line-height: 24px; background-color: white; margin: 0px; font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: black;">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
line-height: 24px; background-color: white; margin: 0px; font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: black;">
My name is Brian Lee, and I am a PhD Security Researcher in SSLab at Georgi=
a Tech. I'd like to privately report a potential security bug in u-boot whe=
re U-Boot USB configuration parsing retains unvalidated interface and endpo=
int counts, which usb_set_maxpacket()
 later uses to walk beyond fixed descriptor arrays. We found the same patte=
rn in 2 different nesting level.</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
line-height: 24px; background-color: white; margin: 0px; font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: black;">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
line-height: 24px; background-color: white; margin: 0px; font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: black;">
<b>Target:</b></div>
<ul data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:false,&quot;u=
norderedStyleType&quot;:2}" style=3D"text-align: left; margin-top: 0px; mar=
gin-bottom: 0px; background-color: white; flex-direction: column; display: =
flex;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: black; align-self: s=
tart; margin: 0px; list-style-position: initial; list-style-type: &quot;- &=
quot;;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"text-align: le=
ft; text-indent: 0px; line-height: 24px; background-color: white; margin: 0=
px;">
Project: u-boot</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: black; list-sty=
le-type: &quot;- &quot;;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"margin: 0px;">=
Repo: https://github.com/u-boot/u-boot</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: black; list-sty=
le-type: &quot;- &quot;;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"margin: 0px;">=
Pinned ref: 3cdce049f90d77c3f9221f1eb73922384c8972c3</div>
<div class=3D"elementToProof" role=3D"presentation" style=3D"margin: 0px;">=
<br>
</div>
</li></ul>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
line-height: 24px; background-color: white; margin: 0px; font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: black;">
<b>Bug 1:</b><br>
A physically present attacker plugs in a malicious USB peripheral that answ=
ers U-Boot's standard GET_DESCRIPTOR requests. The device returns a valid d=
evice descriptor and then a minimal configuration descriptor with wTotalLen=
gth=3D9 and bNumInterfaces=3D255 but
 no interface descriptors. U-Boot copies the advertised interface count, re=
cords zero actually parsed interfaces, ignores the parser return value, and=
 then walks dev-&gt;config.if_desc as if 255 interface records existed, pro=
ducing an out-of-bounds read during
 bootloader enumeration before an OS or higher-level USB policy can interve=
ne.</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
line-height: 24px; background-color: rgb(255, 255, 255); margin: 0px; font-=
family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica,=
 sans-serif; font-size: 12pt; color: black;">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
line-height: 24px; background-color: white; margin: 0px; font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: black;">
<b>Bug2:</b></div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
line-height: 24px; background-color: white; margin: 0px; font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: black;">
The attacker connects a malicious USB peripheral to the target board before=
 or during boot. During normal U-Boot USB host enumeration, the device retu=
rns a valid configuration descriptor containing one interface that claims 2=
55 endpoints while the descriptor
 body contains exactly 16 endpoint descriptors. U-Boot copies the interface=
 descriptor, copies the 16 endpoint descriptors, then uses the unbounded cl=
aimed endpoint count to walk beyond the fixed endpoint array while setting =
max-packet state.</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
line-height: 24px; background-color: white; margin: 0px; font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: black;">
<b><br>
</b></div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
line-height: 24px; background-color: white; margin: 0px; font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: black;">
<b>Attached:</b></div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
line-height: 24px; background-color: white; margin: 0px; font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: black;">
When reporting by email, for better readability of the email and for those =
who prefer private channels when discussing security bugs, we share the ful=
l writeup and PoC files via zip file attachment. If you don't want to downl=
oad an arbitrary zip file and use
 it, please let us know. The zip file contains:</div>
<ul data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:false,&quot;u=
norderedStyleType&quot;:2}" style=3D"text-align: left; margin-top: 0px; mar=
gin-bottom: 0px; background-color: white;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: black; margin-top: 0=
px; margin-bottom: 0px; list-style-position: initial; list-style-type: &quo=
t;- &quot;;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 2=
4px; margin: 0px;">
README.md :&nbsp;full writeup.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: black; margin-t=
op: 0px; margin-bottom: 0px; list-style-position: initial; list-style-type:=
 &quot;- &quot;;">
<div class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 2=
4px; margin: 0px;">
poc : the relevant files and scripts for reproducing the PoC</div>
</li></ul>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
line-height: 24px; background-color: white; margin: 0px; font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: black;">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
line-height: 24px; background-color: white; margin: 0px; font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: black;">
I would like to get help from your expertise to clarify whether this is a v=
alid security threat or not. Thank you.</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
line-height: 24px; background-color: white; margin: 0px; font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: black;">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
line-height: 24px; background-color: white; margin: 0px; font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: black;">
Best Regards,</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
line-height: 24px; background-color: white; margin: 0px; font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: black;">
Brian Lee</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DM6PR07MB43775BFF4B099B0F3988BA78F6A82DM6PR07MB4377namp_--

--_005_DM6PR07MB43775BFF4B099B0F3988BA78F6A82DM6PR07MB4377namp_
Content-Type: application/x-zip-compressed;
	name="INT-usb-uboot-bnuminterfaces-oob.zip"
Content-Description: INT-usb-uboot-bnuminterfaces-oob.zip
Content-Disposition: attachment;
	filename="INT-usb-uboot-bnuminterfaces-oob.zip"; size=12898;
	creation-date="Tue, 01 Sep 2026 00:54:15 GMT";
	modification-date="Tue, 01 Sep 2026 00:54:21 GMT"
Content-Transfer-Encoding: base64

UEsDBBQAAAAIAL0GIV01kTVxeQgAAA0UAAAqAAAASU5ULXVzYi11Ym9vdC1ibnVtaW50ZXJmYWNl
cy1vb2IvUkVBRE1FLm1klVjtcts2Fv1tPgVmMrNrx6I+LCe2lO5O1TTdeqbJZiyn+zUdESRBCTUJ
cAHQstrpzD7EPuE+yZ4LUNank+mP2CYJ3HtxcO+55+YF+xR/o7Vjn6bfsIW2jjnTWGcZzx+EcdKK
nEnlhCl4JlimG+UYL/DMam6sVHNWiCWentbYKHrxgk2bquJmFQXjf7RMaRV/+37jRaimEoY7qRUs
ucXarVsIlqQfmurmyWDCHnjZkPNaIprC6IpxlosHmYnYNnVd0utMq0LOm9ZkLmxmZO20ORotz1zD
y62DbdbbLpuwipcyk7qxPuBa4NMC0ZYs42qDDLt49Wrr4PgTcVVSSWxnozhdOfFsWB2YanxESWPT
mRVuVvHHmmf3wp2eJcxpZgTPETddCUAp5CNOmchiRkb+hbhm7yd/v/lw9+72u8nbd9OfEsaN4SuW
N4bMbgHcZXcLifAsmcwWPC0FS0WhjWA4jq79MmyxK+tExYDZQs5x3rgUD6IMEGgAsmKmUbbDrAao
hcgc3YY01ZKbvYNaD1SKt4bbBZbBJsJ2PJWl/AXP6QpQ4WNBNkqd8eAmXGrXp9CkdRHF7KPRP+Pv
MWviFOmEN7ei1mO2cK62415vLt2iSbuZrnphRe9p4UepFFwYUYzZMMsz0b8cFaN+fnWVDYvRxcWg
GIj0aoi/hteX2fXo6iIbYtsUJzfSrcbs7Y/TKRt2B+yyO+wN+ux///kvS+jlGC97kx/HH3uTt+Mf
eh9vxx96n27Gt73p+FPvLR5u8G8y/j7xp7mlGqMrF9EdbvOhKRVgp5vw2Q9ojPMZRHddNyngXtfM
dqkI5cwKt4GsC4mjxHIWUEPWdNhyIbMF/JSlfUqspt6saKshPLPaCNRFsHyaAL5Kqx52dbPx4OL6
Avb2X45eJ2fd45YRuNr1XOLOZiEvaMGBh9cjMnajjq/vrJmJ6iAQQ3AGNnm22IGLZomr6rQpjnjs
D5OzznaQRAti7RPmOyzs7bA+RSDnClVCzjnF4RqjAhl1QENChKiwvBAoaK5QrkZnQlC4+pnCPohp
cAznwSWgiaIbZWUujoRKwZHvBbDBfWYLkd1bplWJGhX/biSV9vMouVUtfLhkQjzWoZSfXV4KNUeO
tpSRVKLK6tXpHwBX/OewqeMD6VANz769m73964fvbv4ym9788x1O7Hl7+wJjbHJGlyWctgcI97Zl
8QCo4ejVAU6X/f6RdwQdoyLziBlmQ5ILYANudpITBdkdb12lZ7qYycIT7y/C6H33l/1XyZnHzIMs
VWZEhWoM5/Ke8njTT1DPIH9UIwp8yct7otetHtOW4eYGu+xvVD7J8k47Xv7gAU+IscUjehUcjjot
gGsbMZkFdeqaltl7WdeAc32p7dFDyuJzk6FB2YNDDQYH+L26uKYaIY7fywiidBjk1ObUtj5IKKru
ftPWhe+PAQOKqW26AasDUQE4Ydl68JH5dH9oj/eBVkCbAeil0UDS7+g+U2AECZXC7gUfDZHQCuyy
s3bdY+VPm23vVO5ZF7tQBYz66HGJtJ+2ILl9iIdXfUrR7/WSugy+HjRzf/XXPr7EQhlljtFZ16Vh
nWcln4mfVQSnCRK1bHLhPS9QRBTM7rtrz8ITtfqs5Ev1gwg0GIQIhcDngpWyks6nBq7HBIbIjXwI
0qJxsS7QihuV26BnlnSdm5LZphkcVPCKks75THhGqhmRaZPbIBKgA4zOgQ8SNEqSJIXciOgH6/Zq
nfUgWLp4gy8R/XDi0UXTT+/fT27/MWaTPAeMdsqJFZB3YyrGOg58HuPApij1EpasbkwmevuXSO36
IAWDL0rf5Hc6QupKhRSHmDlMmKO+fJpMpr4ua228iCNsd3F/gi4OAtHfAw+qMpPE/FRoJHtJcHjy
E4+4VAoElsKtey82qHqfl4XhFYLVTUnZksuMCA9rGmVEyb1VEggdtEdZojWQquRGEQsVXJYN8gS8
svAs6LMHR0mbOQlKHCPc7k2Fc7poArZxjk5smPLdtV6srCTRyD2veevU9tCbwcms7S9EQXxfwUPz
WKxBfGD6IKyDgu0QZ/C1CF5iShFrBeKPsCGhrVnmYIzxIgBwa1PZzbRjUSDK94AgzkmcUsxhllHh
inBUqhskdFW70MGeju1LXa2VBVeWSgNNRuXc7BQRdX9Bg5RPI05qReZrvbc9FSHOzbDybOsPMHyG
GMRjq3eeRpQjvdBTxZutxgQJt6tcaIKw8G4LzHIdIHx0NgsjjJc3eeep13m3bW63dERGaXG6wvxE
YafCa28y/Ez/oQFp3dRF3nagXKAIwUs+n4UfSGjhcWpDtv2eNvI02V3HQdVvIvJn6cBqKTEirNrq
DmMT7QgDky/JdU2hRA+bjBfXiK2U1mGeOBjaOqHsiL39oLY3ph1keFC4aFrAC8KYMmedycTKSJIV
GMHcE5u1ojkXtfCiaV1L/AHV7x24VUhy5GYuFCUKZnlNY1A431OR4ytEG+GL1PGJzOfUIXaNvWG4
+VwL+r8Gt31zIbthxEs/hyTRRBkE95xmPCY9zXgSyXROilhkjR+c2//LmM8Bisftkei93x/E+LOb
y6KI6AeLY4ygjO90CJbuPEYgSfHIhmkm0rw/KvJuN835FQgsu+6zQb//+vIyiuN4z0p0fn6+b+nr
r1k8fP26c8XOwy+8IMGJK6a58FAVbUmIlgle4vdZxH6N2AltkYBDvolYFJ+QujmV7E+sD0DZV+wL
IgqLzs/PovPP7lur63YxO2lXr5fvr/9s5dD61srJwVFnog5jnD/RGR2J0MLkNyK4/O/RUby2h89n
8ULgGPtOw4xI1k9O2qlQGEOPvwHBL82Vb4AWluPsX17J9hyen8iCndLur/Adj3v+D++eAqcvvZdB
mby83SKTOxJcE1dySK7uy+j/UEsDBBQAAAAIAEoQHF3ljAkgaQMAAKsJAAAuAAAASU5ULXVzYi11
Ym9vdC1ibnVtaW50ZXJmYWNlcy1vb2IvcG9jL2hhcm5lc3MuY61WbW/aMBD+HH6F10kVoHSCbmxM
FKSupBVaVTpo92HVFOXFgNXgZI7Tl63977uz4xBS6DatVRucu8d3z73S14wHURZSckCF4PGbxaD2
uhClMmRPRRHzqzLB+BxlK+FOlgJqp1ZLpSdZQIKYp5JkPGVzTkMSLDxBQnrDAuqGNA2uvpM++VWz
2l2bXE4/ucMLd+h8HR05ds1q3bVaNoHnfvnFPGtWV4nfvkNBW2M+dPGl8758oY0vcMJfcGTXHnvP
svO90AX5jM3XGH4sCB6Nz45HJ7YSocn9TkcbtlrKbxc/Oi3tiHFJ0sxfMolGpYgjd5nO65C6LADP
qe/qbJAmfNorKlHM5yRhCbXJTcxC0vSz2YwKsGwR/YOWI8rncmGT3ByYEPRHRiGmZkplljRqwLyw
iTdCeZ9QiEip9wY3XpRRMhiQbq8KZDykd1XkLmR0NgPspsw1UxHAhbPL01NAqMhF4AJHELYgF1Yd
Q2lgVKAHsnsDrEOWGj2bkXruzsTR76u0T5wv7omDzTE9mozOL8YTsrtrgumvt04Dy2VpLqVW62lh
zidlP2k8q5f0DQA8EhqllPwjD12TKhndJopmnkqIssyt0mgb+VUwf81xChwPh8OJM52ShwdN8Hm0
pns5ObwYjc80TVUhL5CrElqWACOCq3NO5A/IPWc0RnBeXt2x5MC0RmMtaq0F+JIug+S+njc9gu3i
humdlb9cA4oVvce12YPjS8wdWpTC4ymI0KOtJPBHBcyHTfw4jgiPuR/FwbUaPt3y4KNHSt2fn7Vt
81Y23DM3jW0DMsZXseoEr4frZ9H1i+yZasD/GdMmysgtS0JPUneRGZpbiFfcV+qtAsAbaEdQ6HcN
hUslX1F8G9EbGkFPMFnX9YPxtAnl2VIhUOGqacaTSUwz398RFSUa6q6JFuHmvEKX4z4bw47qbaST
yjhZ0XniYkNv4/U5lW4SC+nqTbq14IhHnIkG8u1tKSagzBlRz5QN85yI2N9Wrnw8ZpDYzb6Uant+
lh7jRQmtzT5g/AMvgpGot22zNVWr4J7AjfNK9U2xj/bxi0btD3hgxfukXXwbJRRGQu/F6bnjDN1j
/V2mtEvvLvGCayrRC6DOD48+w+Kcjr45bteAaFLAGL9q4T8Pm3RxJgtlET5GxumtGQHkjan4DVBL
AwQUAAAACACuEBxdNQChdG0IAAAdEwAAKwAAAElOVC11c2ItdWJvb3QtYm51bWludGVyZmFjZXMt
b29iL3BvYy9ydW4uc2iVWO1y27gV/a+nuKE9sbUbSv7YmWyk2LPaRG083dge2/nRSVMZIkEJY5Jg
ANCOa3umv/oAnT7hPknPBagvW26zmUxEEsDBxb3nnnuRjRfd2pruWJVdWV7TWNhpa4POZZ7FiS6d
UKVM6VS/o0wbOjq+iGs7juux1i4el3WhSidNJhJpY63HndYGFp/VJWVGF+SmylKqjEycNrc9DBF1
uqYuO3ZKK382yEpXV/QjjWuVp/h1Rk0m0pAs09jpGD+0DSBdFHiUaXsVLKyegyW5LiVAkqlMrnTt
qFIln8PIjHSZ364uDluuWvIKxsuSsF+lctnNVXlFYgJvWMcjYYeUrK5NIlfhZpavO1gDi5keZVxP
4ma6Kiekyqp23oUX7DmbGFU5whN7uXRKlyLPb+lrraSj3//5n5mpDbSAjxi1QdyyAPJDcTUVVhIc
AXyaaHKaBFXSNAO5nlCGY/a9czyGkZXRaZ3wpoCxaoK9aZuHtBFJLrGgxCYVDHe8cxf04NFUJzVC
5NjbNWwu5Gy5q430VleiVAl1yeLXqX/AVdhNG4dPN0aXk7gxFE6XbYwJhNEyOJDANnBO5B06AcmE
yhk0GJzLawFb+DBMu7qoYANOal0qjUGocGaA4QU4iSjBTDEpNc5/o9yUWeKMuMk5EMx15TpNKCTV
lXVYWnhDGb0JP86uEfjAAhKBGg3Xzj8M4M7G7EwZEIfDzkE6G346H77nUVuPrfxaw188aIODA2NC
aLCXoFLHugLKDXNnsV3Op7klzKMPw8H7p/u3O976kA1AOj65AEoKT3F4RO10IZxKPKk4MEYW+hoz
HRWirP1ndg1dmoJikzVs716SyoBzq2u6YY/DB8jMXKgCLrVXZCvoAWjCbmQ7MRoHG0r5zR80eHb4
rYIyLIiyRBN/0iZDZny2QUC2S+14P228DLTgLYplrXHuSjIj8MknzgjKcxBtbicp4V+8lAJ7RJt3
vw7OP4zOTz6dvRt+3vnyELUjevmSqpu0HbXCEZulC5zG51Gr9en0/OJsOPg4Ohuenow+nf12EE2d
q2yv253AV/W4A83o1jErZPMTLRadHh0fD9+PEJuDaD9JE7nz05vszU76+nWyn73Z29vNduX49T6e
9n/+Kfn5zeu9ZB+bBk0VlNWlz0h4Kgdn8ttXnudeO5z11F8Q3ueynmcJfE5/kbLymYQAqyDuJoZ6
M8Ass0AXKcoeqJlA1S39/q9/g4D4q6zsM5WbpOPvstT1ZEpcKDiy2Puq1DeIHqg4NvpKerojmLz9
KBi93aa7FsFW8I5yMZY5PL0b9clOVeYWI3qyGoHO5p2f/dDBUIR5KqMXCOcvER3ihz/S3uHL3b6X
2BaLr0ymmqLPQZe/0KZf7w8g035QPZ3n+sb2gPFyz69JYHqDNvtkkI+mpF28ZKr14ClXV805Nugo
lUWlWaA7dJTR5eXmgkSXl/M0ld+URYx8Qi2lq4dYpOwr7FZbn4OckfNSg3CYa3UNHRSJ0QiLl4vx
LbKZs8ajIDNC8KAekLKqD1seZe7lIrMRrMf52e54nBPsam6UF8ZK+mjKa64nbI4JMQ1GZUbaKagy
FexGyqRLph4ia6qB/CYS56UwKOA2pFxUi/S20gCZ/HLLOPH4Ng4IjNXug/J5/rSeZ1gxFsmV30jn
4Dsh+1hzYBH0AllyHVxbV7kWqIA8GTzN1MR2aJCB7cG5DeKrEBOIJOxRmWJ9DOXeozzS9aaW3Bjl
EHdCseYGZ16/eEoXZc44JfJ4yStN6iCWvmUi707eBAwhnSE4FsXAiJQTUrD0h96kWehBckTDdAL/
P3+mmNVtQbhuB36I6MsX+pvnLisbZkEA2T/xu5XJEc5wDdcYhNoff++wm8rrbgmfQxQPDjB7jXQx
/PNZxvxl8z3f+WFpQ+b8WsTlPNsJeUY08nk2YrebJtswKRB65Rh+oLjiDeJqzVCSrvnI/lAlO+Xr
/J0LoAPBU0QDRUeVyw6YCX5YDu/zCh9ciuNUVsjr3TXLlv0Wf1128ZIPw/ZzemPen4YX7z6MOCrB
ybmVzcxwmrkwRs3nZx3TYPsUAvC6Ez276glhlk1cf0i/2sdvJuVI+dS/8sPB91GxPfeyZy+vjOjF
9xFyRklPn56HO/AIyCYHXjZdx3qkmegTE9h50W+O8+Ap6WtY06ItEzQoZylj7lqD0hjurlCAlzrY
RZVldS+UMdrYeRnYOp1fU3pbvv0FQ2ftODfIsPb9xyHLz2oN9+2slQHFay63blOVcG0uCuUrze2W
YUGWJlE+QccS4hmaZ/T6UB+JiZaV5UlGh7uAF6XmDvSURPTLM6mNgulVbF4wDw8PafDnIe6Sw/dH
F4Nffxv2Gp3DSGs1k5fqv58SLQUhrEkSirPZVeIAqWu4a4knFJ/sNCIYqzLJ61SuAlqH5rsbakJn
Gn3H3EonI74RCrc0/+jpxJWxhTQ3yLPRlXVTYUrY3UlWc7HL4dMlruhjHmpg9TrPdJ+7lEfe6W/f
vn3G6RjhGDVd9v+M0uxqG+I0iwNfa/j/DShOaMtbyD35j0GvBueD49HJ6cXRyfH5gRiDxSNdjiQT
/2C3Z2+Lsc45cLs40+7/PcqsqvmWD9MFAt+Zt35Bx0FXigvgnX/6+HFw9tceDQIpzmf3zR4rURWP
6yxD/4srj8m4fen8sOzt3v7rHU4/vHCejwrxjZsI6RZGPDLhHueGNtuNv//xnZsLxizeG38Y4TFA
NHORz+1Zz7wVAvW4foSmd5lSK6vWs2dGhoY/ScHafrfbi9GbPUSthK+v0SY+R3Bji4Jmtuf/5RMk
tN/HiA/6o5F+w04/odnqHsj3UdRemdGfG+Kn/tBeakpqKyayR5s7dOeX3PsV90twDwvF93ofHoEk
rUha/wVQSwMEFAAAAAgAShAcXfOqFqyaAAAAWwEAADoAAABJTlQtdXNiLXVib290LWJudW1pbnRl
cmZhY2VzLW9vYi9wb2Mvc3R1YnMvYXNtL2J5dGVvcmRlci5oU85My0tJTVMI8HeOdwz2jXeKDHH1
D3JxDYr34FIGSmTmpWKXy8xLzilNSVWwKS5Jycwr0cuwg6tPLiiNL8mPz0k1NNOo0FTQ0CgFKjA0
iy/RBHI14cpA8iB1QOX4lMXHE6kQSVkxSF1KvkK1ghaIZYtiF0hI01qhVqE8IzMnVUHDANkIYyMM
m0BCqDbBPWhshFVZal5KZhoXAFBLAwQUAAAACABKEBxdKwXelz4AAABUAAAANgAAAElOVC11c2It
dWJvb3QtYm51bWludGVyZmFjZXMtb29iL3BvYy9zdHVicy9hc20vY2FjaGUuaFPOTMtLSU1TCPB3
jncM9o13dnT2cI334FIGCmbmpeIUdwxy9oh38XWM9/X0c/TxdPdTMDbiUk7NS8lM4wIAUEsDBBQA
AAAIAEoQHF0hz4AbLAAAAD8AAAA6AAAASU5ULXVzYi11Ym9vdC1ibnVtaW50ZXJmYWNlcy1vb2Iv
cG9jL3N0dWJzL2FzbS9wcm9jZXNzb3IuaFPOTMtLSU1TCPB3jncM9o0PCPJ3dg0O9g+K9+BSBkpk
5qVil0vNS8lM4wIAUEsDBBQAAAAIAEoQHF08ghwwPQAAAE0AAAA3AAAASU5ULXVzYi11Ym9vdC1i
bnVtaW50ZXJmYWNlcy1vb2IvcG9jL3N0dWJzL2FzbS9zdHJpbmcuaFPOTMtLSU1TCPB3jncM9o0P
Dgny9HOP9+BSBopm5qVikcjMS84pTUlVsCkuKcrMS9fLsONSTs1LyUzjAgBQSwMEFAAAAAgAShAc
XQEbKLt/AAAAuAAAADoAAABJTlQtdXNiLXVib290LWJudW1pbnRlcmZhY2VzLW9vYi9wb2Mvc3R1
YnMvYXNtL3VuYWxpZ25lZC5oU85My0tJTVMI8HeOdwz2jQ/1c/TxdPdzdYn34FIGSmTmpWKXy8xL
zilNSVWwKS4pysxL18uwg6tPTy2JL81LzMlMz0tN0SgoKdJU0NAC05pwNQWlyGrKEnN0FMAKU/IV
qhUgihVsFUASmtYKtQrlGZk5qQoaBkADUvNSMtO4AFBLAwQUAAAACABKEBxdW6kUDE8AAACXAAAA
NAAAAElOVC11c2ItdWJvb3QtYm51bWludGVyZmFjZXMtb29iL3BvYy9zdHVicy9jb21tYW5kLmhT
zkzLS0lNUwjwd4539vf1dfRziffgUgYKZealootm5iXnlKakKtgUl6Rk5utl2KEK5WQmoYsVZeal
Y6jLzCvBEEvKz88BC6bmpWSmcQEAUEsDBBQAAAAIAEoQHF1ZKoSGeAAAAOAAAAAzAAAASU5ULXVz
Yi11Ym9vdC1ibnVtaW50ZXJmYWNlcy1vb2IvcG9jL3N0dWJzL2NvbmZpZy5oU85My0tJTVMI8HeO
d/b3c/N0j/fgUgaKZOalogrCRaEiocFO8b6OESAFIUH+Pj6uQUBmqF+IgiG6yuDI4HhnR2cPVx9P
P9f4YM8oVwVjI3RFYY4+GvkFJZn5eZoKBuiSnsHxrn6OTj6uLljUYJXkUk7NS8lM4wIAUEsDBBQA
AAAIAEoQHF2MnvXkLAAAAD8AAAA9AAAASU5ULXVzYi11Ym9vdC1ibnVtaW50ZXJmYWNlcy1vb2Iv
cG9jL3N0dWJzL2RtL2RldmljZV9jb21wYXQuaFPOTMtLSU1TCPB3jndxDfN0do139vcNcAyJ9+BS
Bkpk5qVil0vNS8lM4wIAUEsDBBQAAAAIAEoQHF0I7PPDMQAAADkAAAAvAAAASU5ULXVzYi11Ym9v
dC1ibnVtaW50ZXJmYWNlcy1vb2IvcG9jL3N0dWJzL2RtLmhTzkzLS0lNUwjwd4538Y334FIG8jLz
UhECxSVFpcklCqUpqWWZyanWXMqpeSmZaVwAUEsDBBQAAAAIAEoQHF058Ay0ZQAAAHwAAAAwAAAA
SU5ULXVzYi11Ym9vdC1ibnVtaW50ZXJmYWNlcy1vb2IvcG9jL3N0dWJzL2Vudi5oU85My0tJTVMI
8HeOd/ULi/fgUgZyM/NSkUSKSxJLMpMVMvNyQOLJ+XnFJQrJGYlFClqpeWXx6aklGshieYm5qZoK
1QoaZfmZKZognrVCUWpJaVGegl+oj4+1Qi2XcmpeSmYaFwBQSwMEFAAAAAgAShAcXVs/mqklAAAA
MQAAADMAAABJTlQtdXNiLXVib290LWJudW1pbnRlcmZhY2VzLW9vYi9wb2Mvc3R1YnMvZmR0ZGVj
LmhTzkzLS0lNUwjwd453cwlxcXWO9+BSBopk5qWiCabmpWSmcQEAUEsDBBQAAAAIAEoQHF1x3DoH
ngAAAGkBAAA7AAAASU5ULXVzYi11Ym9vdC1ibnVtaW50ZXJmYWNlcy1vb2IvcG9jL3N0dWJzL2xp
bnV4L2NvbXBpbGVyLmh9jt0KgkAQRu99CsGbFXwLCRIsJQi6G3bb2RjUUXTFevs0+3EVuho43zkw
ARnWaPw8iyFNjucLxNkhT9LdCfZeMC7E+H8EGFAW45HWtqR6iwBCTCwMF1IlHwqh575DvZZn6uiy
pBujFvdwLf8WJ2haYmuEjHy1SUzdVtKKWYn8l+PG8lps35qpIyqyA3X4JVwTl++Pl+mHTzGyJuM9
AVBLAwQUAAAACABKEBxdxkC4mVwAAACIAAAAOAAAAElOVC11c2ItdWJvb3QtYm51bWludGVyZmFj
ZXMtb29iL3BvYy9zdHVicy9saW51eC9jdHlwZS5oU85My0tJTVMI8HeO9/H0C42Idw6JDHCN9+BS
Bgpn5qXikcksLijKzCvRSNZU0NAozSvOTM9LTVFIzkgs0gSJ2dkqGFQYGSioqSlgkbUBSpqnaXIp
p+alZKZxAQBQSwMEFAAAAAgAShAcXcybp9ZiAAAAeQAAADgAAABJTlQtdXNiLXVib290LWJudW1p
bnRlcmZhY2VzLW9vYi9wb2Mvc3R1YnMvbGludXgvZGVsYXkuaFPOTMtLSU1TCPB3jvfx9AuNiHdx
9XGMjPfgUgYKZ+alYpEpLkksyUxWyMzLAcmX5WemKOSmpOYkVmqU5hVnpuelpijk5OelK+QWpyZr
KlQraICUaIJ41gq1XMqpeSmZaVwAUEsDBBQAAAAIAEoQHF0j5rNXPwAAAFEAAAA5AAAASU5ULXVz
Yi11Ym9vdC1ibnVtaW50ZXJmYWNlcy1vb2IvcG9jL3N0dWJzL2xpbnV4L3N0cmluZy5oU85My0tJ
TVMI8HeO9/H0C42IDw4J8vRzj/fgUgaKZ+alYpXKzEvOKU1JVbApLinKzEvXy7DjUk7NS8lM4wIA
UEsDBBQAAAAIAEoQHF3lTMS4yAAAAFwCAAA4AAAASU5ULXVzYi11Ym9vdC1ibnVtaW50ZXJmYWNl
cy1vb2IvcG9jL3N0dWJzL2xpbnV4L3R5cGVzLmh1kc0KwjAQhO99ikDvgj+UguJFBAXRggp6Ctak
baBspekefHvTLWJi0ssEdpb5hk2sChCyYNlpww/74/XGL/dse+a7KDZjBTLkKHjWKCRb6U6YrUm1
jrr3S/Y5CFqVIAV7Vo+WcY7p0vd01bRdb06TgKuAvPks4NUNlIOYjWTx23CpOvWcL1PbTIeobWKA
p20elTdaSzuPatPUzqKqNA0l5MGEPJiQOwl/90R6Rg6KRsbuib06sJTZ/zY0Rb8m+h3pU2IJQhXR
B1BLAwQUAAAACABKEBxdr+LZ2E4AAACdAAAAMAAAAElOVC11c2ItdWJvb3QtYm51bWludGVyZmFj
ZXMtb29iL3BvYy9zdHVicy9sb2cuaFPOTMtLSU1TCPB3jvfxd4/34FIGcjPzUrGIpKQmlaZr6Onp
aSqk5CtUK9QqlGdk5qQqaBhowtXk5KfHE6MuJTe+PLEoD5eq1LyUzDQuAFBLAwQUAAAACABKEBxd
7RL4EDcAAABFAAAAMwAAAElOVC11c2ItdWJvb3QtYm51bWludGVyZmFjZXMtb29iL3BvYy9zdHVi
cy9tYWxsb2MuaFPOTMtLSU1TCPB3jvd19PEBUh5cykCRzLxUNMHMvOSc0pRUBZvikpSczCS9DDsu
5dS8lMw0LgBQSwMEFAAAAAgAShAcXfTyk2aiAAAA2wAAADUAAABJTlQtdXNiLXVib290LWJudW1p
bnRlcmZhY2VzLW9vYi9wb2Mvc3R1YnMvbWVtYWxpZ24uaGWMwQqCQBRF9/MVD9xoRD9QBCaagVYE
rSKGaeaZD8YxdAwq+vccjTZtLtxzD9ejwigsYL+LeB7nYbZZb3nKvJ6RwT9MRupOISxaqzRdZuXy
p4ZZ1stRGKUxH/3VMUnig28fN5yCEVWfLT0xAEcGcHL9zForLEkgo93RvSYFk0poXUsuhSyRC01X
g8p3Orfflxc0aLvGwKgOYzCHN/PQKCrYB1BLAwQUAAAACABKEBxdmQFl2yIAAAAtAAAAMQAAAElO
VC11c2ItdWJvb3QtYm51bWludGVyZmFjZXMtb29iL3BvYy9zdHVicy9wYXJ0LmhTzkzLS0lNUwjw
d44PcAwKiffgUgbyM/NSUYRS81Iy07gAUEsDBBQAAAAIAEoQHF02Q69t3wAAAJ4BAAA3AAAASU5U
LXVzYi11Ym9vdC1ibnVtaW50ZXJmYWNlcy1vb2IvcG9jL3N0dWJzL3BvY19jb21wYXQuaG2PT2sC
MRDFz+ZTDOylFVFKWS8rgnjxInpoobdlN5ldB+Ik5A+0iN+9iS1LV5vDI/zezMtLQR0r7OB42Nbb
w/64eat3okiEGO8gsdRRIax8UK0xen5a/4GaOH4upDlb0uj+88KXRT82UhKZB6SpvWeOuM8sZ+S6
kT31jAqIA8Qk1aOlDfcQs1bDj95flvV+8wHLsnwthQ9NIJkydPbGi57OVmOdng4m6idp2AeQp8bB
VNrZ722KrOxMTPIBGLdqG4/P4iImDkN0DENS2r6t/UxU4jq0szH4m4giTVAnvgFQSwMEFAAAAAgA
ShAcXUHqrsF5AAAADgEAADMAAABJTlQtdXNiLXVib290LWJudW1pbnRlcmZhY2VzLW9vYi9wb2Mv
c3R1YnMvc3RkaW50LmhTzkzLS0lNUwjwd44PDnHx9AuJ9+BSBopk5qWiCpZUFqSCVBZnpuelpigk
ZyQWKWTmlVjEl1gj5DLyi0pAooZmyMJAARA2NkIWzMnPSweJmpkgi5bmIZtfim4BXBpiUymGVXAF
IDtLMSyFS4NtL4Vbr5yal5KZxgUAUEsDBBQAAAAIAEoQHF379dztlwAAABQBAAAyAAAASU5ULXVz
Yi11Ym9vdC1ibnVtaW50ZXJmYWNlcy1vb2IvcG9jL3N0dWJzL3N0ZGlvLmh9jjEPglAMhHd+RRMW
JeT9AYyLDjphojtBXp80kULaYoy/3ieRgYWll3x311xKgT0GuJSH6no7nsvqlKQREOOSETfP0SPs
1HwtD9fulyx2fozYYJB4w6bpWQ2athbIQmc5OOe2xZQI/8irJw+ZmmDd5bBSUJ6fTu59DDkofbCy
SVa7w2i6GKPRwLehMMwDPIoUSYrsKSRfUEsDBBQAAAAIAEoQHF0b0i4/ngAAAPMAAAAzAAAASU5U
LXVzYi11Ym9vdC1ibnVtaW50ZXJmYWNlcy1vb2IvcG9jL3N0dWJzL3N0ZGxpYi5obY3BCsIwEETv
/YqFXmop/oDiQT0oCAp6L2myaRfSjSRbD369aa0HxdPsvJlhc7Js0MLlvKuvt/3puK0PWZ4IMf5A
Yu0Gg7COYlJh2W2yhycDZa+c87qI9MRaYJTFao70V8Q99k0Ff4o2IBbvyV3Ch6rGB5lwIgNHahkN
OM8tRAniB1doz1FAdypAyWlazXeJbCZLLNCoOH7KEyObvQBQSwMEFAAAAAgAShAcXSdKpaGQAAAA
9gAAADMAAABJTlQtdXNiLXVib290LWJudW1pbnRlcmZhY2VzLW9vYi9wb2Mvc3R1YnMvc3RyaW5n
LmhdjDELwkAMhff7FYEuVQ5BV8XFwbqoqHuRu5QG2rQ0UdBf75UeyHVLvve+l1HFHiu4Xg7l/XE7
nY9lYbJAiHEGiV3z8gg7UR8Kq3pv3h15WLbYuv6TT49HUQuuY1GYiAzOgtAXSwVebP+SoEZJLBAr
pL2RjNNtnydz69n8JrHiKTo0yFF09XMIxZBmyJ4q8wNQSwECFAMUAAAACAC9BiFdNZE1cXkIAAAN
FAAAKgAAAAAAAAAAAAAAgAEAAAAASU5ULXVzYi11Ym9vdC1ibnVtaW50ZXJmYWNlcy1vb2IvUkVB
RE1FLm1kUEsBAhQDFAAAAAgAShAcXeWMCSBpAwAAqwkAAC4AAAAAAAAAAAAAALSBwQgAAElOVC11
c2ItdWJvb3QtYm51bWludGVyZmFjZXMtb29iL3BvYy9oYXJuZXNzLmNQSwECFAMUAAAACACuEBxd
NQChdG0IAAAdEwAAKwAAAAAAAAAAAAAA7YF2DAAASU5ULXVzYi11Ym9vdC1ibnVtaW50ZXJmYWNl
cy1vb2IvcG9jL3J1bi5zaFBLAQIUAxQAAAAIAEoQHF3zqhasmgAAAFsBAAA6AAAAAAAAAAAAAAC0
gSwVAABJTlQtdXNiLXVib290LWJudW1pbnRlcmZhY2VzLW9vYi9wb2Mvc3R1YnMvYXNtL2J5dGVv
cmRlci5oUEsBAhQDFAAAAAgAShAcXSsF3pc+AAAAVAAAADYAAAAAAAAAAAAAALSBHhYAAElOVC11
c2ItdWJvb3QtYm51bWludGVyZmFjZXMtb29iL3BvYy9zdHVicy9hc20vY2FjaGUuaFBLAQIUAxQA
AAAIAEoQHF0hz4AbLAAAAD8AAAA6AAAAAAAAAAAAAAC0gbAWAABJTlQtdXNiLXVib290LWJudW1p
bnRlcmZhY2VzLW9vYi9wb2Mvc3R1YnMvYXNtL3Byb2Nlc3Nvci5oUEsBAhQDFAAAAAgAShAcXTyC
HDA9AAAATQAAADcAAAAAAAAAAAAAALSBNBcAAElOVC11c2ItdWJvb3QtYm51bWludGVyZmFjZXMt
b29iL3BvYy9zdHVicy9hc20vc3RyaW5nLmhQSwECFAMUAAAACABKEBxdARsou38AAAC4AAAAOgAA
AAAAAAAAAAAAtIHGFwAASU5ULXVzYi11Ym9vdC1ibnVtaW50ZXJmYWNlcy1vb2IvcG9jL3N0dWJz
L2FzbS91bmFsaWduZWQuaFBLAQIUAxQAAAAIAEoQHF1bqRQMTwAAAJcAAAA0AAAAAAAAAAAAAAC0
gZ0YAABJTlQtdXNiLXVib290LWJudW1pbnRlcmZhY2VzLW9vYi9wb2Mvc3R1YnMvY29tbWFuZC5o
UEsBAhQDFAAAAAgAShAcXVkqhIZ4AAAA4AAAADMAAAAAAAAAAAAAALSBPhkAAElOVC11c2ItdWJv
b3QtYm51bWludGVyZmFjZXMtb29iL3BvYy9zdHVicy9jb25maWcuaFBLAQIUAxQAAAAIAEoQHF2M
nvXkLAAAAD8AAAA9AAAAAAAAAAAAAAC0gQcaAABJTlQtdXNiLXVib290LWJudW1pbnRlcmZhY2Vz
LW9vYi9wb2Mvc3R1YnMvZG0vZGV2aWNlX2NvbXBhdC5oUEsBAhQDFAAAAAgAShAcXQjs88MxAAAA
OQAAAC8AAAAAAAAAAAAAALSBjhoAAElOVC11c2ItdWJvb3QtYm51bWludGVyZmFjZXMtb29iL3Bv
Yy9zdHVicy9kbS5oUEsBAhQDFAAAAAgAShAcXTnwDLRlAAAAfAAAADAAAAAAAAAAAAAAALSBDBsA
AElOVC11c2ItdWJvb3QtYm51bWludGVyZmFjZXMtb29iL3BvYy9zdHVicy9lbnYuaFBLAQIUAxQA
AAAIAEoQHF1bP5qpJQAAADEAAAAzAAAAAAAAAAAAAAC0gb8bAABJTlQtdXNiLXVib290LWJudW1p
bnRlcmZhY2VzLW9vYi9wb2Mvc3R1YnMvZmR0ZGVjLmhQSwECFAMUAAAACABKEBxdcdw6B54AAABp
AQAAOwAAAAAAAAAAAAAAtIE1HAAASU5ULXVzYi11Ym9vdC1ibnVtaW50ZXJmYWNlcy1vb2IvcG9j
L3N0dWJzL2xpbnV4L2NvbXBpbGVyLmhQSwECFAMUAAAACABKEBxdxkC4mVwAAACIAAAAOAAAAAAA
AAAAAAAAtIEsHQAASU5ULXVzYi11Ym9vdC1ibnVtaW50ZXJmYWNlcy1vb2IvcG9jL3N0dWJzL2xp
bnV4L2N0eXBlLmhQSwECFAMUAAAACABKEBxdzJun1mIAAAB5AAAAOAAAAAAAAAAAAAAAtIHeHQAA
SU5ULXVzYi11Ym9vdC1ibnVtaW50ZXJmYWNlcy1vb2IvcG9jL3N0dWJzL2xpbnV4L2RlbGF5LmhQ
SwECFAMUAAAACABKEBxdI+azVz8AAABRAAAAOQAAAAAAAAAAAAAAtIGWHgAASU5ULXVzYi11Ym9v
dC1ibnVtaW50ZXJmYWNlcy1vb2IvcG9jL3N0dWJzL2xpbnV4L3N0cmluZy5oUEsBAhQDFAAAAAgA
ShAcXeVMxLjIAAAAXAIAADgAAAAAAAAAAAAAALSBLB8AAElOVC11c2ItdWJvb3QtYm51bWludGVy
ZmFjZXMtb29iL3BvYy9zdHVicy9saW51eC90eXBlcy5oUEsBAhQDFAAAAAgAShAcXa/i2dhOAAAA
nQAAADAAAAAAAAAAAAAAALSBSiAAAElOVC11c2ItdWJvb3QtYm51bWludGVyZmFjZXMtb29iL3Bv
Yy9zdHVicy9sb2cuaFBLAQIUAxQAAAAIAEoQHF3tEvgQNwAAAEUAAAAzAAAAAAAAAAAAAAC0geYg
AABJTlQtdXNiLXVib290LWJudW1pbnRlcmZhY2VzLW9vYi9wb2Mvc3R1YnMvbWFsbG9jLmhQSwEC
FAMUAAAACABKEBxd9PKTZqIAAADbAAAANQAAAAAAAAAAAAAAtIFuIQAASU5ULXVzYi11Ym9vdC1i
bnVtaW50ZXJmYWNlcy1vb2IvcG9jL3N0dWJzL21lbWFsaWduLmhQSwECFAMUAAAACABKEBxdmQFl
2yIAAAAtAAAAMQAAAAAAAAAAAAAAtIFjIgAASU5ULXVzYi11Ym9vdC1ibnVtaW50ZXJmYWNlcy1v
b2IvcG9jL3N0dWJzL3BhcnQuaFBLAQIUAxQAAAAIAEoQHF02Q69t3wAAAJ4BAAA3AAAAAAAAAAAA
AAC0gdQiAABJTlQtdXNiLXVib290LWJudW1pbnRlcmZhY2VzLW9vYi9wb2Mvc3R1YnMvcG9jX2Nv
bXBhdC5oUEsBAhQDFAAAAAgAShAcXUHqrsF5AAAADgEAADMAAAAAAAAAAAAAALSBCCQAAElOVC11
c2ItdWJvb3QtYm51bWludGVyZmFjZXMtb29iL3BvYy9zdHVicy9zdGRpbnQuaFBLAQIUAxQAAAAI
AEoQHF379dztlwAAABQBAAAyAAAAAAAAAAAAAAC0gdIkAABJTlQtdXNiLXVib290LWJudW1pbnRl
cmZhY2VzLW9vYi9wb2Mvc3R1YnMvc3RkaW8uaFBLAQIUAxQAAAAIAEoQHF0b0i4/ngAAAPMAAAAz
AAAAAAAAAAAAAAC0gbklAABJTlQtdXNiLXVib290LWJudW1pbnRlcmZhY2VzLW9vYi9wb2Mvc3R1
YnMvc3RkbGliLmhQSwECFAMUAAAACABKEBxdJ0qloZAAAAD2AAAAMwAAAAAAAAAAAAAAtIGoJgAA
SU5ULXVzYi11Ym9vdC1ibnVtaW50ZXJmYWNlcy1vb2IvcG9jL3N0dWJzL3N0cmluZy5oUEsFBgAA
AAAcABwAwwoAAIknAAAAAA==

--_005_DM6PR07MB43775BFF4B099B0F3988BA78F6A82DM6PR07MB4377namp_
Content-Type: application/x-zip-compressed;
	name="INT-usb-uboot-endpoint-count-oob.zip"
Content-Description: INT-usb-uboot-endpoint-count-oob.zip
Content-Disposition: attachment;
	filename="INT-usb-uboot-endpoint-count-oob.zip"; size=10660;
	creation-date="Tue, 01 Sep 2026 00:54:16 GMT";
	modification-date="Tue, 01 Sep 2026 00:54:21 GMT"
Content-Transfer-Encoding: base64

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
UFRxI43T/Unu7svzP3UkjrdwZYxTOHEtGaIFBkvbO6F2QBsNxAGTVis7BgiwbK/QSn+xV57xmb0/
1SALiSoWFpmkKuO0lGT3qWwc3x3G+RefFC5KOvGvHZzihV3Mi8qxFeUozs8v6SlHt9zChVbvJ3jF
N1j1FhTG+b3WYk2XX2iwFFJ3buHjRk56MSDi6JezbvygIdJBsJFnT0o8iTScCLmj6EhAbWqEiW1m
SkD3/wdQSwMEFAAAAAgASmMcXVENjkJyAAAAsgAAADsAAABJTlQtdXNiLXVib290LWVuZHBvaW50
LWNvdW50LW9vYi9wb2MvaW5wdXRzL2FzbS9ieXRlb3JkZXIuaFMuKEpMz01UyM9LTuVSzsxLzilN
SVWwKS5Jycwr0cuw41JOSU3LzEtVSC4ojS/Jj89JNTTTqNBU0NAoBSowNIsv0QRyNeHKQPIgdUDl
RCor1ijQVEjJV6hW0AKxbFGMAAlpWivUKpRnZOakKmgYaHIBAFBLAwQUAAAACABKYxxdeBw1lg8A
AAANAAAAOwAAAElOVC11c2ItdWJvb3QtZW5kcG9pbnQtY291bnQtb29iL3BvYy9pbnB1dHMvYXNt
L3Byb2Nlc3Nvci5oUy4oSkzPTVTIz0tO5QIAUEsDBBQAAAAIAEpjHF0S4tFVZQAAAHoAAAA7AAAA
SU5ULXVzYi11Ym9vdC1lbmRwb2ludC1jb3VudC1vb2IvcG9jL2lucHV0cy9hc20vdW5hbGlnbmVk
LmhNyrEOgyAURuGdp/gTFmhM497qqxgCt3gTvBIrODR9d3UxLmf5js6Li5PDLJ6UZvGpBML7uy4s
8Tn2Sgf6sBAirUMRlzgKBZMtzOOovTyXu9cGxxJm/HBu6GCqfeGPbeREMK1VO1BLAwQUAAAACABK
YxxdeBw1lg8AAAANAAAANQAAAElOVC11c2ItdWJvb3QtZW5kcG9pbnQtY291bnQtb29iL3BvYy9p
bnB1dHMvY29tbWFuZC5oUy4oSkzPTVTIz0tO5QIAUEsDBBQAAAAIAEpjHF14HDWWDwAAAA0AAAA+
AAAASU5ULXVzYi11Ym9vdC1lbmRwb2ludC1jb3VudC1vb2IvcG9jL2lucHV0cy9kbS9kZXZpY2Vf
Y29tcGF0LmhTLihKTM9NVMjPS07lAgBQSwMEFAAAAAgASmMcXRpcMJcfAAAAHQAAADAAAABJTlQt
dXNiLXVib290LWVuZHBvaW50LWNvdW50LW9vYi9wb2MvaW5wdXRzL2RtLmhTLihKTM9NVMjPS07l
Ki4pKk0uUShNSS3LTE615gIAUEsDBBQAAAAIAEpjHF1koD3gTgAAAFwAAAAxAAAASU5ULXVzYi11
Ym9vdC1lbmRwb2ludC1jb3VudC1vb2IvcG9jL2lucHV0cy9lbnYuaE3IMQ6AIAwF0J1T/OgCXoHD
mAYbbCLFQGUx3t24Ob43n41yIVRN7LqRSYLoIcpIVbsh7dSwsI41s/n/KRUOuOFHlS18imhsV1NM
U8TjXlBLAwQUAAAACABKYxxd+1SCy1AAAACMAAAAPAAAAElOVC11c2ItdWJvb3QtZW5kcG9pbnQt
Y291bnQtb29iL3BvYy9pbnB1dHMvbGludXgvY29tcGlsZXIuaFMuKEpMz01UyM9LTuVSTklNy8xL
VcjLz8zLATHi4xNLSooyk0pLUuPjNTRg4pqacKXx8eWpidnoCkFiKIpyEyuTUuNL80qLU1PQFUNE
gcoBUEsDBBQAAAAIAEpjHF3BnlovIgAAACAAAAA5AAAASU5ULXVzYi11Ym9vdC1lbmRwb2ludC1j
b3VudC1vb2IvcG9jL2lucHV0cy9saW51eC9jdHlwZS5oUy4oSkzPTVTIz0tO5VLOzEvOKU1JVbBJ
LqksSNXLsOMCAFBLAwQUAAAACABKYxxdI2BP4EcAAABMAAAAOQAAAElOVC11c2ItdWJvb3QtZW5k
cG9pbnQtY291bnQtb29iL3BvYy9pbnB1dHMvbGludXgvZGVsYXkuaFMuKEpMz01UyM9LTuUqLkks
yUxWyMzLycxLVSjLz0xRyE1JzUms1CjNK85Mz0tNAcqVKOQWpyYXaypUK2iAlGiCudYKtVwAUEsD
BBQAAAAIAEpjHF2gVti9OQAAAFgAAAAxAAAASU5ULXVzYi11Ym9vdC1lbmRwb2ludC1jb3VudC1v
b2IvcG9jL2lucHV0cy9sb2cuaFMuKEpMz01UyM9LTuVSTklNy8xLVUhJTSpN19DT09NUSMlXqFao
VSjPyMxJVdAw0ISrKSiKx6cMAFBLAwQUAAAACABKYxxdpC5QOSMAAAAhAAAANAAAAElOVC11c2It
dWJvb3QtZW5kcG9pbnQtY291bnQtb29iL3BvYy9pbnB1dHMvbWFsbG9jLmhTLihKTM9NVMjPS07l
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
LW9vYi9wb2MvaGFybmVzcy5jUEsBAhQDFAAAAAgASmMcXVENjkJyAAAAsgAAADsAAAAAAAAAAAAA
ALSBYAsAAElOVC11c2ItdWJvb3QtZW5kcG9pbnQtY291bnQtb29iL3BvYy9pbnB1dHMvYXNtL2J5
dGVvcmRlci5oUEsBAhQDFAAAAAgASmMcXXgcNZYPAAAADQAAADsAAAAAAAAAAAAAALSBKwwAAElO
VC11c2ItdWJvb3QtZW5kcG9pbnQtY291bnQtb29iL3BvYy9pbnB1dHMvYXNtL3Byb2Nlc3Nvci5o
UEsBAhQDFAAAAAgASmMcXRLi0VVlAAAAegAAADsAAAAAAAAAAAAAALSBkwwAAElOVC11c2ItdWJv
b3QtZW5kcG9pbnQtY291bnQtb29iL3BvYy9pbnB1dHMvYXNtL3VuYWxpZ25lZC5oUEsBAhQDFAAA
AAgASmMcXXgcNZYPAAAADQAAADUAAAAAAAAAAAAAALSBUQ0AAElOVC11c2ItdWJvb3QtZW5kcG9p
bnQtY291bnQtb29iL3BvYy9pbnB1dHMvY29tbWFuZC5oUEsBAhQDFAAAAAgASmMcXXgcNZYPAAAA
DQAAAD4AAAAAAAAAAAAAALSBsw0AAElOVC11c2ItdWJvb3QtZW5kcG9pbnQtY291bnQtb29iL3Bv
Yy9pbnB1dHMvZG0vZGV2aWNlX2NvbXBhdC5oUEsBAhQDFAAAAAgASmMcXRpcMJcfAAAAHQAAADAA
AAAAAAAAAAAAALSBHg4AAElOVC11c2ItdWJvb3QtZW5kcG9pbnQtY291bnQtb29iL3BvYy9pbnB1
dHMvZG0uaFBLAQIUAxQAAAAIAEpjHF1koD3gTgAAAFwAAAAxAAAAAAAAAAAAAAC0gYsOAABJTlQt
dXNiLXVib290LWVuZHBvaW50LWNvdW50LW9vYi9wb2MvaW5wdXRzL2Vudi5oUEsBAhQDFAAAAAgA
SmMcXftUgstQAAAAjAAAADwAAAAAAAAAAAAAALSBKA8AAElOVC11c2ItdWJvb3QtZW5kcG9pbnQt
Y291bnQtb29iL3BvYy9pbnB1dHMvbGludXgvY29tcGlsZXIuaFBLAQIUAxQAAAAIAEpjHF3Bnlov
IgAAACAAAAA5AAAAAAAAAAAAAAC0gdIPAABJTlQtdXNiLXVib290LWVuZHBvaW50LWNvdW50LW9v
Yi9wb2MvaW5wdXRzL2xpbnV4L2N0eXBlLmhQSwECFAMUAAAACABKYxxdI2BP4EcAAABMAAAAOQAA
AAAAAAAAAAAAtIFLEAAASU5ULXVzYi11Ym9vdC1lbmRwb2ludC1jb3VudC1vb2IvcG9jL2lucHV0
cy9saW51eC9kZWxheS5oUEsBAhQDFAAAAAgASmMcXaBW2L05AAAAWAAAADEAAAAAAAAAAAAAALSB
6RAAAElOVC11c2ItdWJvb3QtZW5kcG9pbnQtY291bnQtb29iL3BvYy9pbnB1dHMvbG9nLmhQSwEC
FAMUAAAACABKYxxdpC5QOSMAAAAhAAAANAAAAAAAAAAAAAAAtIFxEQAASU5ULXVzYi11Ym9vdC1l
bmRwb2ludC1jb3VudC1vb2IvcG9jL2lucHV0cy9tYWxsb2MuaFBLAQIUAxQAAAAIAEpjHF3Fs6BK
pQAAAM8AAAA2AAAAAAAAAAAAAAC0geYRAABJTlQtdXNiLXVib290LWVuZHBvaW50LWNvdW50LW9v
Yi9wb2MvaW5wdXRzL21lbWFsaWduLmhQSwECFAMUAAAACABKYxxdUTtOfSwHAACjGAAAMQAAAAAA
AAAAAAAAtIHfEgAASU5ULXVzYi11Ym9vdC1lbmRwb2ludC1jb3VudC1vb2IvcG9jL2lucHV0cy91
c2IuaFBLAQIUAxQAAAAIAHNjHF3fXB1gWwgAAFASAAArAAAAAAAAAAAAAADtgVoaAABJTlQtdXNi
LXVib290LWVuZHBvaW50LWNvdW50LW9vYi9wb2MvcnVuLnNoUEsFBgAAAAARABEAkAYAAP4iAAAA
AA==

--_005_DM6PR07MB43775BFF4B099B0F3988BA78F6A82DM6PR07MB4377namp_--
