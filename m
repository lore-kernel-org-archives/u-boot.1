Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03748CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:27:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5A736073D;
	Mon, 19 Oct 2026 10:27:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H8PHY1kg0IgJ; Mon, 19 Oct 2026 10:27:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 00142606F4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792405658;
	b=eBI+rt7weTMSQfs2QeGZnBR5c1jSxImisRfE2UjHFszT/Ougd6dAsfqK6TVCR0lqVC5v
	 yvNBPVjKYklDM9WySdYf1PCKKu1gvRXvPK8k4hKZpRkPECi0Kra2CXCERJUZe+5Luswci
	 +Sq9htBvLEO86FO3IsdlqUvX2GDkOamOCsRQFyVCDztbbEbTmSOqkbMawICNbEGFYfCdV
	 uZO5/bukSAzPCsOKs2VJ6k66XTKn/0Y4sYL6KWMIQm4K24eYYXtKMF/jM11a1R5idH1Wp
	 PS9rdfYvdodY3tTZF1VkgDdMxSSdC+MVRZMbdNh/PKLRKlZOJYwxpdTDz/IUkVYhmfw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792405658;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yPz+9ecqKKIjYDqLCNCM7zD7u2zJ9sFuQwDKNBQE2gE=;
	b=eBpIjRN3PBUVg43vzvVf9fsPBYukK4JFfaalKIpvVfPr+dOTYRGnB6qsbfmsvOvhYrSP
	 wd8Chq8zhVAjN9wxLHgwijf3HHW9VJyDG9XKgJzH7vZVTSQRwoXlv6NLJs8m0n/iBKvvS
	 BewHlqqqbQwNLi8CJCqm2fEBMbIUiyvd04ttHdd9Cq+Qmt49t1+wRWui+q197mCINQxo0
	 mQv1UMPdSWmKMh5qJQ4VFm0HUDbk4G8Ex9GP+rprESFSLZxetF4ZNN3oh+BezAqDKEY9E
	 2Z4/cCgu3cj52hZax2S2ko7J2m1Q9mpJW777DDOm25pugz8Glkx4mdoNjvBitE8Uh2w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792405658;
	bh=yPz+9ecqKKIjYDqLCNCM7zD7u2zJ9sFuQwDKNBQE2gE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oyIUonWBLN1Pmcrwp6qmte0dBsB0lKdSi/KKuiYNmoD5U2JSZfFW7odWqF9sxCgme
	 xF/ONMCwtneciKYR3hikJDjaRcaKMXji/1uCSCH8vO7jXGDHwYOOWXaWoO7QuNxGYh
	 jaVYTul+A2GE8iwxno+1wygGhlXjLgzkc7kdqZsYhdZRc6Z9Myv3m3HO1LrrQG9UJV
	 nedd7CCHRWkDOo5b1KDcRhPdixTDy3qqWeo5cbhV0rUpZRBQ1OSCLlAJbGhM6piT35
	 l0eGHGU7BrOv77+dBsMYghbDL6nu6bQKCdWFevl7Aq8Fk2J2svshSG+zh1u004XA/d
	 F0QD5MME3kyOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00142606F4;
	Mon, 19 Oct 2026 10:27:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CE6342A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:27:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BFE11406AC
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:27:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Np5JzgH9dvec for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:27:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2BDB6406FC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792405656;
 b=OANMe2bRVTRfvgGxF3Uds/fryFsYhgUtjfLAWYb80nUNyA/yQWmjKvsCv3KKPabC/AB1
 ZH9NGDIsUZonDfqkN5foOC7oyiRMq+pRl2cICZan50P0CpEvLCeUq5LKUJ2i2BwkaPkwB
 RXkKt4ZlAU+6j5p/cxzOcOK0DA/XRCQhaSmNmbikc5/TeFmR4NToscoLgbj7pPeS4MA0z
 BpFNraoFdkZfpUltr6/TWT2zFSBqZpAwVDlLCXo4WdcifRGyEAkz/Aan1j5qP+Z9X+CFr
 J725b0yEAnzrCgxtj/O1ogx+FflArmMu837q9opzZ95prb/6gPNSlW9VB3PHYo998+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792405656;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=yPz+9ecqKKIjYDqLCNCM7zD7u2zJ9sFuQwDKNBQE2gE=;
 b=J9Eh6yQTxYB0X+6m0C6IAII6WYXej0QSA2TZQ7SHJM5Drj4CU2AMxiEd+GjQI5gQ05yg
 gFU6RVFrq8SxThNTIP2FFLt96NBfFH1t3J3DLq3wpGRcjiXb7aMYUS5RykVnI03tc9dYB
 r21iVZc2sIodSsnz4rC6OyxI+8isnQw+hS/iHvht6Z3yaw19Sys4lSh9cMi29CzpfQfaQ
 oyKJ024hQIr0/IXPzgL0Y2M/HhocWNdVtyuWw9QWrXzWaIFUp/otkjLFpvf4dMzDGjRDv
 rtVqbmdSl7VfFz2knTd/seaDwNGiZWe51MqOggHMipoVwuZ3QR3j3sj++q4Zc4vRP4g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Llzupmhm; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=D551WpA2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Llzupmhm; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=D551WpA2
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2BDB6406FC
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:27:35 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OmeB3305151
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yPz+9ecqKKIjYDqLCNCM7zD7u2zJ9sFuQwDKNBQE2gE=; b=LlzupmhmhoJaOW3S
 6Dn+NjIruFfQvMHCzNiVqzzXNsinyBPE1Z1qI9kbkUzWHXdBCogRY1st3Xr6oRoY
 X5zSD+tJafrVYidrSfAPsFbeep0YrrjDbFJMMJeHlPyV/wrxPwoKiptwnRYrdXmb
 QvW7aTSUI8JNtI/kCAG98FYudyq8np4F9WPRKBUyPeeoGhY2e9AOCsAK8OcsLcvo
 J4C9mMYwu6N1+mOjWv+fGXlaNp7ZvJoTmIRJ5HK2Kd4OdxkhZnx5PE0YUto7vtF7
 K4C5+3UE03wC3og6Epb8lF2SUEaMVjdqWxMcnEpRRaWXkKBPg09pIthno3WSlvK0
 dCML1Q==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47gm3b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:27:34 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-679c17e5084so2886882d50.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:27:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792405654; cv=none;
 d=google.com; s=arc-20260327;
 b=YTpORztcT3r5m+Ip1o+0OonAfDncNUm3gBYBExFBuXlo3KuXJ7cDdPGhBXZ1SYIbW7
 mYr/4pQDifj9DO8PcXUSUMlW0zXdyygp62+sDOouqgqkmT6Qp/dSJwVL1v7iPQvcBO/B
 byouoNcH7cEf7QAow7mfm4yJrENPQIL6a3yNb62F4trBsF1M/xT7hfbLdY5p12AeH7AK
 U1bOSxmRFllSzEegsICsfpIep4YdzFdwZbNfhWv0NYJJilWKONeVfDmNMEdIgUcQyhKM
 TDrkn7MATIeMNOCl9Z5oPJchtZhLe0FZ7rV7OOPOPOMjRzS+Kr+zNpLycZAnMHQwzl8p
 XpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yPz+9ecqKKIjYDqLCNCM7zD7u2zJ9sFuQwDKNBQE2gE=;
 fh=s/eksSFHYX351p9gNPHsd0hSLLSJ7BAZlTj76HEQmP8=;
 b=a1VwdOUFrKsgbDSwHUk1INlorMHRkSXPrr9ix8/8p0wofSoyBH0QAmiMWBFx1iD6dO
 soZ3X971yIPmwzx60zFHJbQNuZdL6+RJ8YNc4jYznikYvrsIcasrwMfixrHwXyS0jzIM
 8OVuGo9AeygoS/pckqAK70DyOfn7iLDRLnL87qwcfAtWKsFK4EL+8ND4nilV65ae3Epk
 V/WYVYgEkNKxjLv6YEMvOpI9RRf1gb3LD2OOdhnHn46NN7T9TngGwFWfVcPEdOJImdxd
 E+PovORG3CNv2GDrD0TmyxTp02nyMPh39SGQW4G1VOTMS6vDDEEVK5ULwrq+K+SzfUjw
 yZoA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792405654; x=1793010454;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yPz+9ecqKKIjYDqLCNCM7zD7u2zJ9sFuQwDKNBQE2gE=;
 b=D551WpA2W0/yQwSBAq6U4Bl2rOKrDsYzJzuqE9OgspC4WLiPy/NEzgnGFsBSd0Pn4S
 F6wKr6tEWD3yTZiRWruCcbHneKkGQwVp8O9t8u8cESC0yAUuLIctVglFKxqOVOc7n5D1
 v67OwjmnxdS9LTLSNgjET2iJfqbc4IZxljmffJ0yxncXtNPyG4nptf4JPb0OwzcMAA+/
 c6K5DsbkHW9Gp5zmgBe2rf8dX5EzxeYJYYil4vmQ4WY6CJQsEGNrv1QGgm+x+rYBgWwN
 6SXNGOCuZRw68GsCOGTlntaGwcn1hmJeDCEVwqhD+k3RKXSIqi8WFy85Gd3U1N4bcs7o
 3eXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792405654; x=1793010454;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yPz+9ecqKKIjYDqLCNCM7zD7u2zJ9sFuQwDKNBQE2gE=;
 b=xHJAE+DWAotez3dNw4vzS0JR/EybeB9HLmqStbhCcq3kJQOn5kGR6x/Pvsa23TDx1G
 Qd1rj9P7BN54h1+Kl7nEPM29KHooS/GTwmF3IM0f5Zgqp9A1aP5cF+e4IDvt7F262WoM
 7wMUskb2OHPNDgGK0aAS9JFG8qMjhy/Q4+Nqoe6LG5fM8MdLy3jNBEpxEyPTIEMpEVi3
 EDE7bY6Bt/WIwsS1J9JgZkUchd6dlLvannvdMM4Ggk53I7knY43QsIcGpqxba1uTSSvW
 T+hOa6oXYGrc6WSmC81+Y3+YKKTTVGQ5a16oOFgNDCyCL3X4P0FSnSx87oE1CS3bUZDz
 3PfA==
X-Forwarded-Encrypted: i=1;
 AKwUvByzedU18RThueOxhC70JKiihUs2fvt2JQPre8RhXQEnAF4i7n91dAZnIXvdWlB2lZeWQtmEmGk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKtsXYNbkbMBzZr4IxUAZuTfNKmJLpEvTlPiiux1PDM9LHZy+IG
 iPrpXL8D7QokyEI9dvpP7J9jULg63IWe2es71XTjYl3UVmChxC7O+/hrQ0GiGjBiU82cspx23p5
 ihGSvPd+pngO+esK+58KFA4G7JadZSoBA2V0nbKy2NWpPxUt22Y/KXQ3Byik3itHUy4TGGIDQ8x
 BbyRwh7Z0TlFsLIPNXGLu6IkoYdDLz6twZGHzxwVGePJ+cWg==
X-Gm-Gg: AYBFou1N0PscXB5ieiEQGMwfKljdyz6zG3AswXMFmoht2SpYKx4uKxANHUYGpMf0n6a
 GP2sl0CAM2bXMToiiomX5PxVveA4hI3xG4RNnCnPgKG1pkcwKy8LfTQgOdrH47Q85w6+zC2x53i
 1QzfDJw8hdg70fFypo+6hYR3w8NpRD34c6H+ANKq+ZtC77t9V05dHQVtGAsQ==
X-Received: by 2002:a05:690e:d50:b0:679:c17e:407f with SMTP id
 956f58d0204a3-679ca57248fmr1319654d50.10.1792405654085; 
 Mon, 19 Oct 2026 03:27:34 -0700 (PDT)
X-Received: by 2002:a05:690e:d50:b0:679:c17e:407f with SMTP id
 956f58d0204a3-679ca57248fmr1319647d50.10.1792405653539; Mon, 19 Oct 2026
 03:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-3-9e5b82644359@kernel.org>
In-Reply-To: <20261015-test-avb-fixes-v1-3-9e5b82644359@kernel.org>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:27:22 +0200
X-Gm-Features: AclHuK8df1gijlHtD_LA78zH3AnBUgaCWjjBiTmi99xP9PYizTlXuVHimm3FTSI
Message-ID: <CAPzfCAZ0afkBjxKyqSqniGQ=5PS0NWTFRjk_N8c15+ctR_o3-Q@mail.gmail.com>
Subject: Re: [PATCH 03/10] test/py: android: Drop verbose printing and unused
 return
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org,
 Jan Kehren <jan.kehren@emteria.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: s_4L1DSivoGEk00rb8d5hsJzkjgpkNuf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfXzlXvSeGIMJ0r
 fti6iW10qz+NjGV08HHQs0F2CY6fnf1FE13gxlzixR7UC1SNKuMIpy9nI658+4q6vJOc94UPh+j
 MfGlJth6Sgyp1GoNmAstgK0Rk4ByNXcqHcg6fn5ZTc/4wNyn4RHHwZSSwdXu73dOadSpyUIeQ0s
 DmT6soPyLcQ6yBkg55TxlCt4yKpHc8m/FGOiNCw18dJ4SF8vEcx2gW5wUr4vROHCc64THbhvh0M
 PQS2SscyMiByDPOYUWGLV8lUyqH5YCid++IsJ8AoiMwmL63cN+cIr396ulR+1QwmvYdGoc6MeJs
 nEervMKgIE28l+NaHdeBy4YdI38UkPrNAkBOcloWaWTBHq4IhfZR9L1NDXCcAwZ3or3f70fhrTA
 U5GWkD8rGmnL42nr7Gq0qpDw4arWn1XJ89YKnIUTmCMsMPfAQuM7x8nOPyoCJ3SddsVFIXK6Oci
 k04ymd6IkBuH2MyjMHQ==
X-Proofpoint-GUID: s_4L1DSivoGEk00rb8d5hsJzkjgpkNuf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX2FZhQzM/Zux/
 NSlqZB53WiOtkXiAxd6USD0DC/zpDsGJKMpDot7YbI/DEJxmm+AR8/ZMhrnVRcPOV1inObVxrng
 WHO4uhtdjodpSr/1JOvV63bnNxs3bAQ=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad5f097 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=55ZzZ9NNzk2StOPLXLMA:9 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190041
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

Hi Mattijs,

On Thu, Oct 15, 2026 at 3:55=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> The setup_android_image() is only called once. The callers does not use
> the return value.
>
> Drop the unused return. While at it, also remove the verbose printing.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
>  test/py/tests/test_android/android_image.py | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/=
test_android/android_image.py
> index 3bea311586bf..8b536754656e 100644
> --- a/test/py/tests/test_android/android_image.py
> +++ b/test/py/tests/test_android/android_image.py
> @@ -81,8 +81,6 @@ def setup_android_image(ubman):
>      with open(fname, 'wb') as outf:
>          outf.write(disk_data)
>
> -    print(f'wrote to {fname}')
> -
>      mmc_dev =3D 8
>      fname =3D os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
>      utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
> @@ -129,7 +127,3 @@ def setup_android_image(ubman):
>
>      with open(fname, 'wb') as outf:
>          outf.write(disk_data)
> -
> -    print(f'wrote to {fname}')
> -
> -    return fname
>
> --
> 2.56.0
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
