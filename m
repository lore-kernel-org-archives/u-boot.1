Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF51C61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 15:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51B9060855;
	Fri, 28 Aug 2026 15:53:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xSUci8Ezg5xK; Fri, 28 Aug 2026 15:53:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787932381;
	bh=BTS5rvmhaBnh55TeTYdzuLiv3b/o1uvbLXQ9pYn0NBs=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cGGNR/w2XXwJ/EoqQ+5BgfKETf7SNSJGDEW2ERKMTRtnp8Z5juRr6A6cBRlEASJ+W
	 dgfLR+YyeOusRwCPls2PXNCa8C21XV/aTwu76l/QfwHgCtIIi8OFpxyDhs31u5dNWn
	 r21lFcLwLbFnOWHsM1xy/KQMSE2+rkR6zGX7jFvmIbGBObSTBTkRywe2T7y3BtYtg3
	 aKGLl5+CLy2qnXImldW/TBICWy3a/SnTcwn8sh+4f9hdY4UCTsObfCZ6Y2Aki11qRT
	 HRpIcvwNFas8EOjWKj6XDBXNgBYAJNvpNxE7ldj0gTMFuXZgvBCZHrmdlT3oJZMTEB
	 dZ7PF2POWqj5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96A366081A;
	Fri, 28 Aug 2026 15:53:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 189D178B
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 15:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF78480E9C
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 15:26:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vrWBPqCmdBnL for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 15:26:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=hibrian827@gatech.edu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=gatech.edu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gatech.edu header.i=@gatech.edu header.a=rsa-sha256
 header.s=selector2 header.b=RhkByX5G
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 27F5380E92
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 15:26:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPWraJglKt4fhY0tCEVE5mrNJogoC+eAlXh0GaKARW5wgOm0QbRc5oWtwuNvj+EaW+sf2A/C5e9cRBVh5NCctslS93l/ZWYNz2gczn9UMXauR3IgGr7XdhB/OZvNwkLgVx987IBAzMM3g6KB4iwcQmWWOnrwRSPPg17xK67NKheAFxrkmK2zrsROzU1lFSmkY/F3XrohmbZJreFvt5ZKCU0MIHia7qcDHdQ5qW0EqUlEpsZaBM4iD2p69pJOyM2IcP7/TdncR/j+5M/CNcWQFAXPaw78rLcTqvbnDz6i/VRRXwfGBfgYnCr/Oh3Ybvj+S/W0gCtzyzSgejjhey4Mvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTS5rvmhaBnh55TeTYdzuLiv3b/o1uvbLXQ9pYn0NBs=;
 b=V6i3o3Kl0qJRd26wiR5nVlfBg+dU3+KwgoflxMNlAgcr4XWWp114PnEDUFbn7o2Kv/siKSVCwFuIWevxUCNakJL0GCW+zE9lMPUzHpfwzTNcOlVqficdti+dmqGrLUMPnVsVsfzOdItiWQrVrkcOHbOG16ph5S/tx7cy5OSLyMrwWUjUCz3t7gM6rlo8giLncKQcKPgFPWTesMWgL/g4zBHAroCq5bQY16wgWZk9G3Pu+/cqOj63X7Z457IxQZE+E3j+17yyR+nr/8/PPZ5JURhQAroOipHBq7+/N8Kn/AaYBXUoM1D08+LfBiEGUNpYZk9HSJMzDWqm88QrFlboOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gatech.edu; dmarc=pass action=none header.from=gatech.edu;
 dkim=pass header.d=gatech.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gatech.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTS5rvmhaBnh55TeTYdzuLiv3b/o1uvbLXQ9pYn0NBs=;
 b=RhkByX5Gl4OLHWkNfet4OHhotEQFjbXh79zkkz92fOHpQM9A4gaFWYq59XnwByt2X8XXOECxFdolIWsLAPetXBFnrshe9zy3fRLbHTr/+Y606vTksyvQb0icNjzgKfnjYEiDgmVSYUjLqjnV7wIRQhpOFi7BqGzBr+rvZ6Wl/95C0c8bYZ2bw1SZaO4w6rH1gCT3l6OmybxbGBXApwSZ19YbfLldfRRxYnPYhK9vfDgOb+NsEGAFaAAtjGqbb1NCUmAsj5ORNPuyl+IrtlYVdZw1NFzM1Z++o9qvBbYQ/ZUjKtmv2hVGKHMG7mJ85V8TljZmUusbEP3+T7D9I8sl0g==
Received: from DM6PR07MB4377.namprd07.prod.outlook.com (2603:10b6:5:bf::19) by
 MW4PR07MB9592.namprd07.prod.outlook.com (2603:10b6:303:22e::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.11; Fri, 28 Aug 2026 15:26:17 +0000
Received: from DM6PR07MB4377.namprd07.prod.outlook.com
 ([fe80::3bd2:fc9d:167d:e059]) by DM6PR07MB4377.namprd07.prod.outlook.com
 ([fe80::3bd2:fc9d:167d:e059%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:26:17 +0000
From: "Lee, Brian J" <hibrian827@gatech.edu>
To: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
CC: "Kim, Youngjoon" <ykim3186@gatech.edu>
Subject: U-Boot USB storage BBB CBW leaks uninitialized CDB tail bytes
Thread-Topic: U-Boot USB storage BBB CBW leaks uninitialized CDB tail bytes
Thread-Index: AQHdNwEVCnV54d6lO0Odb341uo0u6Q==
Date: Fri, 28 Aug 2026 15:26:17 +0000
Message-ID: <DM6PR07MB43775950972F53F93C3BD558F6AC2@DM6PR07MB4377.namprd07.prod.outlook.com>
Accept-Language: en-US, ko-KR
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gatech.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR07MB4377:EE_|MW4PR07MB9592:EE_
x-ms-office365-filtering-correlation-id: ee272699-23a9-4faa-26bf-08df0518b485
x-gt-tenant: 042d12d7-75fe-4547-b5b6-0573f80f829d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|786006|23010399003|6049299003|376014|366016|1800799024|10067099003|6133799003|3023799007|18002099003|11063799006|56012099006|8096899003|4053099003|38070700021;
x-microsoft-antispam-message-info: Lndr5+f+TicXKAwXsD9soQZrmbH1+Xxy1E1dexhttp8nQnPOn5e+wtYWgW310A8v37CWe+fnhhukPhL3HRkq9S2hrcQWLvtDeAEve16Hc3ZfC4KILyJtalNTRtAthya1cqrQnHVe6k/sAzWsIta7QTYBOKj7L5bMT6KkLYFe3dAZsnKNDoxWdD5kipbeghlxUvnZVJNEkYzss2+AwFPrFthOowHF5at50tSfZ+v50yBPdvt6EHdymfZbtLUvOrJjOLYAARVw88KziT7SW9KIL6sQUb6nxCsT06Q/V8jxQnPCipRVYRZHG7t+c/QzEp5r3hOv0AmNrxOsVAU4D7kfqpw+x+XzzJUEKamKuXSH4jM/zbWj9x3tvQMxgFMncGdSN9Z91ZuMaJZL7IiF8mA5qqXH8vI3VnI7VXK/CtxtUzCFFyPyd/XsWQCAH5tkC4/y4zoNMfuls3Mnnrhr8O34f0EAmcJAWqPUxYb/uaYfEP3cA4FsWos3pBev9e4fUhlJwtJ534OLFrKIbpwlpDImcdem3t6uXZzRD/6mDv04EDlmXUXAM68gZ0ifH3iMtT++T2cbXPZZwT/q3OFIvME8DUY0Nzny90y7NMNkqvA2HMp3zut/h22CeQAYmQI+Kb3YoexCXxcb2OjxgRL0Hnx8L7jRgrV3jmIt0I8AzVDkiJ8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR07MB4377.namprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(23010399003)(6049299003)(376014)(366016)(1800799024)(10067099003)(6133799003)(3023799007)(18002099003)(11063799006)(56012099006)(8096899003)(4053099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g7lXrShYm+3XIS92a96leOlVfNCX6yo6u/1fRPdUVBQKDFR1xOoxAtfbVN?=
 =?iso-8859-1?Q?bVBhQzLrQ8wEXcl0V2yE2XDwwlj2Mz6jM5jEvVR46nrGUJk2+ECt124HRl?=
 =?iso-8859-1?Q?ICI6UI5yHzpuoYksCLgzDlggZMGg/4Jyu7I1H5jipTCn17rzLE3gYrg84Z?=
 =?iso-8859-1?Q?Tf0wd/Mevu35kQrPhOAwQ0VMhbsmkpxablU5GtaLI2Op43BXiFGW95Cuz/?=
 =?iso-8859-1?Q?jShmkYMQULhMKb063k5zTSBprrzRqqGVXcs/Zu/tKW+QpFEooNFma7WCNR?=
 =?iso-8859-1?Q?OePvd47ZvXpdFNeHkYBBjXpRrCpviHT8M1WGE/ejIIZikT8v01I1pN//Lv?=
 =?iso-8859-1?Q?quWf25XTQGKmmgBP1n806OeFUsYGfKMaMIcIQfjIzu50QoTJGuSDqujQoN?=
 =?iso-8859-1?Q?DT/kv8hKcmS/Xoi0wbPg5tdZ36d6XRQ27L7/nV0BgvVgVUGokHse0wkqHl?=
 =?iso-8859-1?Q?I9a5niZPbBxk3aVQD1FMSZfPdyCURdkBwI1jtc/+Eph/qq16IKkT3bQeuN?=
 =?iso-8859-1?Q?ORJk2JGZpCzK3xAWx2lAAz38CVTCXzisp8RPjfxxJJpclobcq3kV4Rshd0?=
 =?iso-8859-1?Q?zlN1/BV005EofFiDkRF9Cdebt0ZNtRsGgCVlvqacDBauy/x+E7oUjtlYDt?=
 =?iso-8859-1?Q?brEgftvfPom8lqFlWkZZgxBtlED2D78jxl+WldT1pdUdOWyi1Y38kC/C4S?=
 =?iso-8859-1?Q?1jMACR4mJHjkC/edTKqinDn6vnPNZZxv2xj6w3b7W2wDh1K9e7ruHeur+x?=
 =?iso-8859-1?Q?G0N7Yxty0m6nT9OkNuucCdbfJ080PiWG9ChiHtD+lmuSaczN6rCW9v/CIF?=
 =?iso-8859-1?Q?KZsSBTWQxh8OwJnFHHONghVJHwzg54ruKJezeEmdsGAjk33gVy4C2LgZtf?=
 =?iso-8859-1?Q?lXx2Xl/ONyTy6IqUGcX2thifMKzOjQq6xlx8Zfmh4tEBUun4URnwOK3WEb?=
 =?iso-8859-1?Q?0QPHstCyPzNzqJJXUddcexa+Ccq56I6C6gJwAQcJC3rdiZhVFeACLa15eQ?=
 =?iso-8859-1?Q?kfcOAznSCLVI3KFYKCq1PgfSmO8yaRSIAVHkqn1lMEKEWrixisyNL78iEW?=
 =?iso-8859-1?Q?UNBB8XRjs1F0jH9pOW5ebUeEppCGxhBOLKiaYbtVLs1LDQCUkzqZxX1P6r?=
 =?iso-8859-1?Q?LFwK6RaDiQdr1tjON+dFdd1yk3XYthjUu1yZmnsSHuEBLQRrg0tSMZxMRq?=
 =?iso-8859-1?Q?O/lo/jq7IAaTObPP0jAmRc4vgjAp00F77aac4WR9CDU/QS281zRH0R9V9i?=
 =?iso-8859-1?Q?tIfDWaM5phTgqqtlcmiwYQ0CC5WVc+Bf6L640yLYvHKYvUQYyolI19rYav?=
 =?iso-8859-1?Q?BjSjhCtaSonC3jXISFfW4hb9NCfTPqZRv5lhmb8fX1i4Hf8NXv/VhFpFks?=
 =?iso-8859-1?Q?/ZA2w2Q3qL0gxKF1iZZuea8FaWfl5Sb506igRI5jHppaN76AEN7Ep/rtvC?=
 =?iso-8859-1?Q?u8q7OPx2g+Imh/wm0jvrlL+yZv0L9T+HaEa1U7pKrT3Vcfa2YY3Z9dAgsj?=
 =?iso-8859-1?Q?/EmBUjZLgVccaR+bKiflL+Mez9Zrgu4A/OUzSafb5i+oGd6S5GhrqJkEs5?=
 =?iso-8859-1?Q?hyE2AtDVsJbf8Vf76AbUaLcAyT0x+hWrEyro0bfB5X5DIV/+DxSutClA3Q?=
 =?iso-8859-1?Q?TO7wCwLMC4/2swwU+mi8hJSYmgPQJAKRtR/mp3CeH2fukXYzlmO3p2WPUI?=
 =?iso-8859-1?Q?uv/f4fvOINDsFTPr9RwFQnqLOWHGgGDbqJR8T8eKS7zuC7JFcC7hP90DLx?=
 =?iso-8859-1?Q?iMafQjqbMDA76Pv1PvWgVwIDIFr/i8NQbUd6Nu1rajtFjA?=
Content-Type: multipart/mixed;
 boundary="_004_DM6PR07MB43775950972F53F93C3BD558F6AC2DM6PR07MB4377namp_"
MIME-Version: 1.0
X-OriginatorOrg: gatech.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB4377.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee272699-23a9-4faa-26bf-08df0518b485
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 15:26:17.5310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 482198bb-ae7b-4b25-8b7a-6d7f32faa083
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XaFEF8vrOy2nuWxXGSr8hA75wZuacbvLzDoNNOlV9cDWqAVkK6FJqE8EXBTHj8bFbS8h0M/uxJN8oT/+YFwxwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR07MB9592
X-Mailman-Approved-At: Fri, 28 Aug 2026 15:53:00 +0000
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

--_004_DM6PR07MB43775950972F53F93C3BD558F6AC2DM6PR07MB4377namp_
Content-Type: multipart/alternative;
	boundary="_000_DM6PR07MB43775950972F53F93C3BD558F6AC2DM6PR07MB4377namp_"

--_000_DM6PR07MB43775950972F53F93C3BD558F6AC2DM6PR07MB4377namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

My name is Brian Lee, and I am a PhD Security Researcher in SSLab at Georgi=
a Tech. I'd like to privately report a potential security bug in u-boot whe=
re the malicious peripheral learns a small amount of bootloader stack resid=
ue during USB storage enumeration. In a realistic bootloader context this c=
an disclose low-volume process/firmware state such as stale stack bytes or =
address material useful for follow-on local exploit development.

Target:

  *
Project: u-boot
  *
Repo: https://github.com/u-boot/u-boot
  *
Pinned ref: 3cdce049f90d77c3f9221f1eb73922384c8972c3


Threat Model:
An attacker with physical access plugs in a malicious USB storage device be=
fore the target enters U-Boot storage discovery, or induces an operator/boo=
t flow to scan attached USB storage. The device advertises an ordinary bulk=
-only SCSI mass-storage interface, passes U-Boot's class/protocol/endpoint =
checks, and receives the Command Block Wrapper for the normal six-byte INQU=
IRY command. Because U-Boot sends the full 31-byte CBW after initializing o=
nly the six semantic CDB bytes, the device can read ten stale stack bytes i=
n the CBW CDB tail over its bulk OUT endpoint.


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


--_000_DM6PR07MB43775950972F53F93C3BD558F6AC2DM6PR07MB4377namp_
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
re the malicious peripheral learns a small amount of bootloader stack resid=
ue during USB storage enumeration.
 In a realistic bootloader context this can disclose low-volume process/fir=
mware state such as stale stack bytes or address material useful for follow=
-on local exploit development.</div>
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
<div class=3D"elementToProof" role=3D"presentation">Repo: https://github.co=
m/u-boot/u-boot</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: black; list-sty=
le-type: &quot;- &quot;;">
<div role=3D"presentation">Pinned ref: 3cdce049f90d77c3f9221f1eb73922384c89=
72c3</div>
<div class=3D"elementToProof" role=3D"presentation" style=3D"margin: 0px;">=
<br>
</div>
</li></ul>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
line-height: 24px; background-color: white; margin: 0px; font-family: Aptos=
, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 12pt; color: black;">
<b>Threat Model:</b><br>
An attacker with physical access plugs in a malicious USB storage device be=
fore the target enters U-Boot storage discovery, or induces an operator/boo=
t flow to scan attached USB storage. The device advertises an ordinary bulk=
-only SCSI mass-storage interface,
 passes U-Boot's class/protocol/endpoint checks, and receives the Command B=
lock Wrapper for the normal six-byte INQUIRY command. Because U-Boot sends =
the full 31-byte CBW after initializing only the six semantic CDB bytes, th=
e device can read ten stale stack
 bytes in the CBW CDB tail over its bulk OUT endpoint.</div>
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
<br>
</div>
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DM6PR07MB43775950972F53F93C3BD558F6AC2DM6PR07MB4377namp_--

--_004_DM6PR07MB43775950972F53F93C3BD558F6AC2DM6PR07MB4377namp_
Content-Type: application/x-zip-compressed;
	name="INT-usb-uboot-bbb-cbw-cdb-tail-info-leak.zip"
Content-Description: INT-usb-uboot-bbb-cbw-cdb-tail-info-leak.zip
Content-Disposition: attachment;
	filename="INT-usb-uboot-bbb-cbw-cdb-tail-info-leak.zip"; size=12806;
	creation-date="Fri, 28 Aug 2026 15:26:06 GMT";
	modification-date="Fri, 28 Aug 2026 15:26:17 GMT"
Content-Transfer-Encoding: base64

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
NEQfUCDCBMyWUEd3HD7b82PpP1BLAwQUAAAACADWYhxdQ2+/l24AAADfAAAAQwAAAElOVC11c2It
dWJvb3QtYmJiLWNidy1jZGItdGFpbC1pbmZvLWxlYWsvcG9jL2lucHV0cy9hc20vYnl0ZW9yZGVy
LmhTLihKTM9NVMjPS07lUs7MS84pTUlVsCkuScnMK9HLsONSTklNy8xLVUguKI0vyY/PSTU20qjQ
VNDQKAUqMDaKL9EEcjXhykDyIHVA5fiUQU1LgpoWH59UmplTkpkXn1RcnlgAFMShLwnVeIL6AFBL
AwQUAAAACADWYhxdBoONIisAAAApAAAAPwAAAElOVC11c2ItdWJvb3QtYmJiLWNidy1jZGItdGFp
bC1pbmZvLWxlYWsvcG9jL2lucHV0cy9hc20vY2FjaGUuaFMuKEpMz01UyM9LTuVSTklNy8xLVXAM
cvaId/F1jPf19HP08XT3U7DgAgBQSwMEFAAAAAgA1mIcXXgcNZYPAAAADQAAAEMAAABJTlQtdXNi
LXVib290LWJiYi1jYnctY2RiLXRhaWwtaW5mby1sZWFrL3BvYy9pbnB1dHMvYXNtL3Byb2Nlc3Nv
ci5oUy4oSkzPTVTIz0tO5QIAUEsDBBQAAAAIANZiHF0lAT8VIQAAAB8AAAA5AAAASU5ULXVzYi11
Ym9vdC1iYmItY2J3LWNkYi10YWlsLWluZm8tbGVhay9wb2MvaW5wdXRzL2Jsay5oUy4oSkzPTVTI
z0tO5VLOzEvOKU1JVVAqSCwq0ctQ4gIAUEsDBBQAAAAIANZiHF14HDWWDwAAAA0AAAA9AAAASU5U
LXVzYi11Ym9vdC1iYmItY2J3LWNkYi10YWlsLWluZm8tbGVhay9wb2MvaW5wdXRzL2Jvb3RkZXYu
aFMuKEpMz01UyM9LTuUCAFBLAwQUAAAACADWYhxdeBw1lg8AAAANAAAAPwAAAElOVC11c2ItdWJv
b3QtYmJiLWNidy1jZGItdGFpbC1pbmZvLWxlYWsvcG9jL2lucHV0cy9ib3VuY2VidWYuaFMuKEpM
z01UyM9LTuUCAFBLAwQUAAAACADWYhxdeBw1lg8AAAANAAAAPQAAAElOVC11c2ItdWJvb3QtYmJi
LWNidy1jZGItdGFpbC1pbmZvLWxlYWsvcG9jL2lucHV0cy9jb21tYW5kLmhTLihKTM9NVMjPS07l
AgBQSwMEFAAAAAgA1mIcXXgcNZYPAAAADQAAAEgAAABJTlQtdXNiLXVib290LWJiYi1jYnctY2Ri
LXRhaWwtaW5mby1sZWFrL3BvYy9pbnB1dHMvZG0vZGV2aWNlLWludGVybmFsLmhTLihKTM9NVMjP
S07lAgBQSwMEFAAAAAgA1mIcXXgcNZYPAAAADQAAAD4AAABJTlQtdXNiLXVib290LWJiYi1jYnct
Y2RiLXRhaWwtaW5mby1sZWFrL3BvYy9pbnB1dHMvZG0vbGlzdHMuaFMuKEpMz01UyM9LTuUCAFBL
AwQUAAAACADWYhxdGlwwlx8AAAAdAAAAOAAAAElOVC11c2ItdWJvb3QtYmJiLWNidy1jZGItdGFp
bC1pbmZvLWxlYWsvcG9jL2lucHV0cy9kbS5oUy4oSkzPTVTIz0tO5SouKSpNLlEoTUkty0xOteYC
AFBLAwQUAAAACADWYhxdWV0aCkgAAABNAAAAQQAAAElOVC11c2ItdWJvb3QtYmJiLWNidy1jZGIt
dGFpbC1pbmZvLWxlYWsvcG9jL2lucHV0cy9saW51eC9kZWxheS5oHcrBCYAwDAXQe6f44KWdwWlC
GkqgScVUQcTdRY8P3rLt1IwwnCXFpKkM9a4uOIdWWJVOVz48tLlU9OENFsJRcCN/p/xc8aQXUEsD
BBQAAAAIANZiHF173dyDYQAAAH4AAABJAAAASU5ULXVzYi11Ym9vdC1iYmItY2J3LWNkYi10YWls
LWluZm8tbGVhay9wb2MvaW5wdXRzL2xpbnV4L2RtYS1kaXJlY3Rpb24uaFMuKEpMz01UyM9LTuVK
zSvNVUjJTYxPSSwBEplFqcklmfl5CtVcCgouvo7xTp4unkGuziGe/n6OPgq2CgY6UIkQ/3gX1zBP
Z1egoCFM0C3I3xchbAQT9vP3A/GNuWqtuQBQSwMEFAAAAAgA1mIcXaBW2L05AAAAWAAAADkAAABJ
TlQtdXNiLXVib290LWJiYi1jYnctY2RiLXRhaWwtaW5mby1sZWFrL3BvYy9pbnB1dHMvbG9nLmhT
LihKTM9NVMjPS07lUk5JTcvMS1VISU0qTdfQ09PTVEjJV6hWqFUoz8jMSVXQMNCEqykoisenDABQ
SwMEFAAAAAgA1mIcXXgcNZYPAAAADQAAADwAAABJTlQtdXNiLXVib290LWJiYi1jYnctY2RiLXRh
aWwtaW5mby1sZWFrL3BvYy9pbnB1dHMvbWFwbWVtLmhTLihKTM9NVMjPS07lAgBQSwMEFAAAAAgA
1mIcXcohrGi6AAAAjQEAAD4AAABJTlQtdXNiLXVib290LWJiYi1jYnctY2RiLXRhaWwtaW5mby1s
ZWFrL3BvYy9pbnB1dHMvbWVtYWxpZ24uaKWQwQqCQBiE7z7FghcXonOHCDZdU1CLoFPEz7b7Vwvr
KrpC9fRlgh2iLl0GZgY+hvHrRpxLQSor0fO1laZTSOatU0Yfp5eF5ys8aYuEbcMEopxBnhYsS1cF
mY0dgDD6bFEFV9ob5xp97BwCBMG7ofQNy7J1CCELEw4vGCx3ccy3gbvVOCFWlE9t9R0p6ZNXsO/9
YUREPE4L/h/j2wzYsOgDMyG1UD9YP/4phTGVBCnkBcerhmlDNRjvAVBLAwQUAAAACADWYhxd5wOx
mjUBAAD+AgAAOgAAAElOVC11c2ItdWJvb3QtYmJiLWNidy1jZGItdGFpbC1pbmZvLWxlYWsvcG9j
L2lucHV0cy9wYXJ0LmitksFKw0AQhu95isEiNKUICiISEfTgyTcoEja703TpdjbM7ka09N2dhDRK
o+LBHMLO/8/OfJnMrGFV7xR40pjNLGmXDMJdiMZSvNjcZ/GtQYNrSBRsTWjAearBVUr8MhbZTExL
CM+PD09wdu7SWRYiJx2hctvSYNCwzwAkGwy2lHbFEEXFNcZj5BIdj0k7FUJpzVFoFEsr4RivDucJ
01QUiPA+NvH11SiMeXqjGBh3vlWV6+v2SotkPK9uX0alYW/kw1aXN58aY2uD9bS67rXWWwOLhm07
RZkvKuf1tmRUJp+fDmkwZUbLcbqdS7yUSr89X7M1xeUAUaX1Gjn/meOVbcT/BJmSaE8hnvIcCtkQ
Fa2Wf+K61el96VfK3ChOgbp3DnuYd4l5FxVw+K5GvyiW7J9rfABQSwMEFAAAAAgA1mIcXSCA041h
AQAAFwMAADoAAABJTlQtdXNiLXVib290LWJiYi1jYnctY2RiLXRhaWwtaW5mby1sZWFrL3BvYy9p
bnB1dHMvc2NzaS5odZJRa8IwEMff+ynCfNE9SOs2GTgGxRZXmDJbZQyRIzaxBtpUksuYjH33pZUx
2upLH36//u8ux/WOimYFJaVMudMTMs0N4+RJIxMSh4fnf3ZT8ILmIpPDw42DpyNnfE+M1JZwRtID
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
ut2ZolkIY9Y+/mFiWuzYQgB+KqIfnnpEmFUXnw4yno71m0s5Wj6PP/nL/h+jYneR5chePpnRsz9G
yDklI332Itx+REA3BfCynTqeRpqLPjGBQxT9NpyHSMl4h7Uj2ipBk3JWWvDUmpTG8XSFC3hlgl3e
sqzuU+OcdX5xDWx+XLym7G3G8RcMnY/jPCDD26Nfj1l+1u/wOM56nVCi5vLoNjGK7+bp1MSb5nbT
sSBrp0xs0JGGeKbhGbM+1Edjo2dledTR6V0gilL7DvSYRPTLD1obF2ZUsbaFV/t05XaPW7KVFCfl
U4oE5pl9tbNDYkzibJtEwfMwfBWFw0QnasuvR64VPFHMhyThdfz0eJbLIFd+/1a+FGKslk/asydr
PsXXMZ+tLq7wNT1dOzCRrsLI1FOLM/apKPv/6zU65qydetfHpUdDUbtrPhP9X9bW5ye6v8f00DCX
xqg8iSlkbfPT6cnpyeXJwYeTv6Guh+9+Gx4evRteHpx8wBAS9NAWBZphf3OOlOIH1F3LpsquvVO2
lDPpXTi98MXmG3w3gQ3aPhyg/5AVNWUFudvZE5gAHrKO4pekbAOPM4DBaGzJ7uI/FlKjDgZYidn4
bmXQ0ixuaHN5D+T7LOuu7RgsXuvj1j91V66+xsux3qONbbqLR+7jifsVuIelrsRo0lcgaS9V579Q
SwECFAMUAAAACAD9ehxdSfMfxBQIAADJEAAAMgAAAAAAAAAAAAAAgAEAAAAASU5ULXVzYi11Ym9v
dC1iYmItY2J3LWNkYi10YWlsLWluZm8tbGVhay9SRUFETUUubWRQSwECFAMUAAAACADgYhxdGZ/J
25sFAAC4DwAANgAAAAAAAAAAAAAAtIFkCAAASU5ULXVzYi11Ym9vdC1iYmItY2J3LWNkYi10YWls
LWluZm8tbGVhay9wb2MvaGFybmVzcy5jUEsBAhQDFAAAAAgA1mIcXUNvv5duAAAA3wAAAEMAAAAA
AAAAAAAAALSBUw4AAElOVC11c2ItdWJvb3QtYmJiLWNidy1jZGItdGFpbC1pbmZvLWxlYWsvcG9j
L2lucHV0cy9hc20vYnl0ZW9yZGVyLmhQSwECFAMUAAAACADWYhxdBoONIisAAAApAAAAPwAAAAAA
AAAAAAAAtIEiDwAASU5ULXVzYi11Ym9vdC1iYmItY2J3LWNkYi10YWlsLWluZm8tbGVhay9wb2Mv
aW5wdXRzL2FzbS9jYWNoZS5oUEsBAhQDFAAAAAgA1mIcXXgcNZYPAAAADQAAAEMAAAAAAAAAAAAA
ALSBqg8AAElOVC11c2ItdWJvb3QtYmJiLWNidy1jZGItdGFpbC1pbmZvLWxlYWsvcG9jL2lucHV0
cy9hc20vcHJvY2Vzc29yLmhQSwECFAMUAAAACADWYhxdJQE/FSEAAAAfAAAAOQAAAAAAAAAAAAAA
tIEaEAAASU5ULXVzYi11Ym9vdC1iYmItY2J3LWNkYi10YWlsLWluZm8tbGVhay9wb2MvaW5wdXRz
L2Jsay5oUEsBAhQDFAAAAAgA1mIcXXgcNZYPAAAADQAAAD0AAAAAAAAAAAAAALSBkhAAAElOVC11
c2ItdWJvb3QtYmJiLWNidy1jZGItdGFpbC1pbmZvLWxlYWsvcG9jL2lucHV0cy9ib290ZGV2LmhQ
SwECFAMUAAAACADWYhxdeBw1lg8AAAANAAAAPwAAAAAAAAAAAAAAtIH8EAAASU5ULXVzYi11Ym9v
dC1iYmItY2J3LWNkYi10YWlsLWluZm8tbGVhay9wb2MvaW5wdXRzL2JvdW5jZWJ1Zi5oUEsBAhQD
FAAAAAgA1mIcXXgcNZYPAAAADQAAAD0AAAAAAAAAAAAAALSBaBEAAElOVC11c2ItdWJvb3QtYmJi
LWNidy1jZGItdGFpbC1pbmZvLWxlYWsvcG9jL2lucHV0cy9jb21tYW5kLmhQSwECFAMUAAAACADW
YhxdeBw1lg8AAAANAAAASAAAAAAAAAAAAAAAtIHSEQAASU5ULXVzYi11Ym9vdC1iYmItY2J3LWNk
Yi10YWlsLWluZm8tbGVhay9wb2MvaW5wdXRzL2RtL2RldmljZS1pbnRlcm5hbC5oUEsBAhQDFAAA
AAgA1mIcXXgcNZYPAAAADQAAAD4AAAAAAAAAAAAAALSBRxIAAElOVC11c2ItdWJvb3QtYmJiLWNi
dy1jZGItdGFpbC1pbmZvLWxlYWsvcG9jL2lucHV0cy9kbS9saXN0cy5oUEsBAhQDFAAAAAgA1mIc
XRpcMJcfAAAAHQAAADgAAAAAAAAAAAAAALSBshIAAElOVC11c2ItdWJvb3QtYmJiLWNidy1jZGIt
dGFpbC1pbmZvLWxlYWsvcG9jL2lucHV0cy9kbS5oUEsBAhQDFAAAAAgA1mIcXVldGgpIAAAATQAA
AEEAAAAAAAAAAAAAALSBJxMAAElOVC11c2ItdWJvb3QtYmJiLWNidy1jZGItdGFpbC1pbmZvLWxl
YWsvcG9jL2lucHV0cy9saW51eC9kZWxheS5oUEsBAhQDFAAAAAgA1mIcXXvd3INhAAAAfgAAAEkA
AAAAAAAAAAAAALSBzhMAAElOVC11c2ItdWJvb3QtYmJiLWNidy1jZGItdGFpbC1pbmZvLWxlYWsv
cG9jL2lucHV0cy9saW51eC9kbWEtZGlyZWN0aW9uLmhQSwECFAMUAAAACADWYhxdoFbYvTkAAABY
AAAAOQAAAAAAAAAAAAAAtIGWFAAASU5ULXVzYi11Ym9vdC1iYmItY2J3LWNkYi10YWlsLWluZm8t
bGVhay9wb2MvaW5wdXRzL2xvZy5oUEsBAhQDFAAAAAgA1mIcXXgcNZYPAAAADQAAADwAAAAAAAAA
AAAAALSBJhUAAElOVC11c2ItdWJvb3QtYmJiLWNidy1jZGItdGFpbC1pbmZvLWxlYWsvcG9jL2lu
cHV0cy9tYXBtZW0uaFBLAQIUAxQAAAAIANZiHF3KIaxougAAAI0BAAA+AAAAAAAAAAAAAAC0gY8V
AABJTlQtdXNiLXVib290LWJiYi1jYnctY2RiLXRhaWwtaW5mby1sZWFrL3BvYy9pbnB1dHMvbWVt
YWxpZ24uaFBLAQIUAxQAAAAIANZiHF3nA7GaNQEAAP4CAAA6AAAAAAAAAAAAAAC0gaUWAABJTlQt
dXNiLXVib290LWJiYi1jYnctY2RiLXRhaWwtaW5mby1sZWFrL3BvYy9pbnB1dHMvcGFydC5oUEsB
AhQDFAAAAAgA1mIcXSCA041hAQAAFwMAADoAAAAAAAAAAAAAALSBMhgAAElOVC11c2ItdWJvb3Qt
YmJiLWNidy1jZGItdGFpbC1pbmZvLWxlYWsvcG9jL2lucHV0cy9zY3NpLmhQSwECFAMUAAAACADW
YhxdgCvoiaQGAACKFgAAOQAAAAAAAAAAAAAAtIHrGQAASU5ULXVzYi11Ym9vdC1iYmItY2J3LWNk
Yi10YWlsLWluZm8tbGVhay9wb2MvaW5wdXRzL3VzYi5oUEsBAhQDFAAAAAgAGmMcXSfAKSr5BwAA
ixEAADMAAAAAAAAAAAAAAO2B5iAAAElOVC11c2ItdWJvb3QtYmJiLWNidy1jZGItdGFpbC1pbmZv
LWxlYWsvcG9jL3J1bi5zaFBLBQYAAAAAFQAVAMAIAAAwKQAAAAA=

--_004_DM6PR07MB43775950972F53F93C3BD558F6AC2DM6PR07MB4377namp_--
