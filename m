Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95191C3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:51:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F925407F3;
	Wed, 14 Oct 2026 16:51:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Stful6cLi3Qh; Wed, 14 Oct 2026 16:51:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 45E7B407A2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791996717;
	b=ikp9Hel5dWycY4vXo0HJPnpPE/tAauKKvCRSCIEo4S2rV93XFDmud9+0i9bYbCNjuvIX
	 M8zKFZnpGznB4h928gOmbiOm4EfI+JXJDXt0wHcjMVAReFr0Po26UuU+78e+AG7mHPUgC
	 CRj+0Ror07mLrmu7mdIhBHhqmcNQUAclhTehoKyzuoeGIvP5ZJLEFL9YLb3NDXmrOQcgr
	 2/+vx33BHGyCVmOEPrQ/SQNouRsm4UxSPFx5pS6jsotguEAsaWlu5FFznuzWxDlIWkqMp
	 Ghx5epQezE0pkQK7kBZII10EBYHUwLSKmGGzRRSMnz0FHFjYzjveGopMJi3g56kP5kg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791996717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QoEsfTo8WOjhCNFv9VFa8NaKqTa8SriPBo9RLZ4At9k=;
	b=s5rV3wCxlQaEK+F9fgWpCF8pWwnGzcsKX0UZ58Q+T5PDBYnMwwd+1SgF3P3ktULrLsrU
	 ngEs2ttgVCBug6euihnGH/kZsb0t25AerBpuJE/0DBi7n/w3yrLJV0IU5bFKk2i6y5Qgv
	 GXl11JHShFB+sgYgFsBkNVXKTmsTCqUMZCgkpLoVueGMHfkSSU/aqbcl1M3zL0dwa8ATb
	 mK0WeFyBewMAa9oP1RGiDnB8W3SQL8ThLj0pItjCLZLvgUdepWiJq5l9KPBaBcZ4cZqC3
	 aEFHNUz6une71GVkiLDy5s6C9espuz/+Mw+ROf+ZVLOxvqjqGy/Uyx0SaqXPkfRTPZw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791996717;
	bh=QoEsfTo8WOjhCNFv9VFa8NaKqTa8SriPBo9RLZ4At9k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p63P1er1yWJhYcRlO6xvj5GMzlqcoNJRPkOCXKmzShw8n3heyEDdId7Y8BuVH9cSX
	 swiYMwUY2oCsOqPcsQofDh6Q/OyxUP4RUaw007uR/Z2Vh2CLWRPYUUxS/4gk80Ijwo
	 I1SjVVWMnXqCgYl3JWG51obpoA2dF1cS01GqP/EBYXAJqm2zdj15FczeBC3SBvUC6+
	 2ZBIqGVTCehe5mqHmZvzBuPZz7Z+XoCsCf6v9oe09AT7xxlELfiT+SaS9vvOt866yM
	 16y6iS2YoTUffT7TkUAe1+SBH/iQRoM6w58P/31XDcGqm1/xEzoLXmUCy2hhEcTsOM
	 shJrVGu1vPCvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45E7B407A2;
	Wed, 14 Oct 2026 16:51:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 672591DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D12C607ED
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p3M6dFQ59e-M for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:51:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7678A607C3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791996715;
 b=jn06Krq05loxgBa0wwhtFtj60X4xiV6Y96RvTr1fWd7QAP6O5QKAFJiuGNemP1t+w5v8
 F+eJDyGqEZUyz+NwX4bw50zAv79dkOFHUI7qG4P5hFnIoEAmOedjw9Ti6YJvOifgE5GHo
 YKIDnUwlGx8dchb2KbNmnM8N39YdxzoaOO1U0JhSahOcE7Ub21SdiwxJ6Hj8D96RZKtYX
 G6MKqKf65Ip/J+1lvEZIYbYUqeTV3O5kIc7333MJQ6HoKONxIOVM+3WGyYcOkepi5Ccug
 YIA0+BcHq7jpF757wIAE4QKmK8v99fsV9xwh9IrMFhH21B0yXLnYRryCZJUr7qMNWjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791996715;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=QoEsfTo8WOjhCNFv9VFa8NaKqTa8SriPBo9RLZ4At9k=;
 b=TiCkkufc6esPab6b4mDhqxsp6OSDI20qNxj0a2xRqPcOA/40JEp3g0E4YRCdAEUtddTd
 ufELiToojZeACgjzJZ4aonEZ/1dm3IpghecTSZppJsxSKH6AopHg/uahoUt4fegMzsBdp
 1MaglWdpTEhcQIr60opYsn0MIb3t+hf7XWcFPLnST7UA26nKlg6PNaMBkcYUqcuSvl9vO
 3XdW0W3z1qSclk66dZuvPfxSYSRIIyq6/hQutG/V9A39wYyC1GLY4WQ6WRi7HDqCwoCmI
 dwlqocjrtP5mLUCxhT5Nw0jAnXH/sNkW5AAIBObrNJIr0FmNkdJnw6R+UGw7eUj4mEA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=d47FmA8h; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XoqFv2IY; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=d47FmA8h; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XoqFv2IY
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7678A607C3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:54 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbJX6152429
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QoEsfTo8WOjhCNFv9VFa8NaKqTa8SriPBo9RLZ4At9k=; b=d47FmA8hbZHYZTwk
 Yag8Af7WwBfxHm6FrW31ej5woZN3/G2MExRB3mdxO0rzuxB/TmMtlYk72qKL23In
 Y3rFtGxG5WSHBj6FXehWzaqVgpWxfMSqWiPaF3DDMrLALFWr9g/RFxBRQ8OSXni0
 hvr4TgDupERekS6WIkHD7eE5Nh8ZPln2z6JX7R5eRnXdZ/cWu97RtoZAWV2R3l3o
 Tu5JfbWrznVziv4mC4+sfxLHKnctHSl1aczNK+VHt0g5fGsf3vxLhFdUK8lQwHG2
 l97yhhem5ejrjlor+vH6/uuWiPEFgjwyJVSBVWBAl5DYbzLS3rAQ6KPf/zecnfvF
 IO6AYQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha7aehq96-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:53 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-17188d538c7so7677818c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791996713; x=1792601513;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QoEsfTo8WOjhCNFv9VFa8NaKqTa8SriPBo9RLZ4At9k=;
 b=XoqFv2IYVBYhDfQfcnBzvYOvHXDvP1xvw7FRHu4qXY7MrC1WbkOCe7kBwdmoYyPJEH
 j5ZV9VUHEZydepXNFUPoJpInXhER8wC6Hji5w0Iziz0xO/oOKNd8yTq0MSOkrtVrJhMo
 Wbsmsy0Xm9ZS2YnBcJfuhLDvp5mMqlcR4++VIWctPK9NlhrFtZL7K4E1YeWu1gFp2D2S
 evWGP8LTJkig3odHniK5vG49AoW446Yh4Ywcw5YNCEnLI1Hs4JvjTZbOD5lIfWzu/lXV
 gOhqs26M3H5hvmpDFH5Cwx+9sL0gd/6zjbnIz3ERykiUeYiJtZrzL/H/wkd4VNJ3QFIw
 kUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996713; x=1792601513;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QoEsfTo8WOjhCNFv9VFa8NaKqTa8SriPBo9RLZ4At9k=;
 b=b8Xl3XCVW/B4TxSU1+crj753uum18wCzXoDbuIYBTLZdJngF4HuCfVCyRNv9+5HFM2
 0d19s3Z54je9xUdD2EQtJP5oX7Es2IcTMlr247YnONM2FgwnjsWZ+tSlD4SWkbID0feQ
 sz3vVdsGrAIGI0Xp6VFEvyelbdsnEoM/N91k7m8Z4ZLIgE9V6hjpeGGEgRH43ZcOlg99
 ep3RNC1kf9VSahgTS+coas35Nxvh3Voj/2YGPJWyGGS8IwMakXuQ9/Rheodjtp1X/WQ0
 l81RphYsUkGIGHsrDN3JXljv5iulAFtLfHJddCL9dM1j2DwaQ9lxm2/vkb3VZLnevgNU
 lyuQ==
X-Gm-Message-State: AFq9FYK9LqHL95Tb1aDrW2WwOECRICyHE5GSIk4qHOr0WhpBWWMwnrnA
 c2BYiy62z37q/o++NiUSbXwxlXWRnn9NhIoCZ7oqs88mtjoGfwoDtoEg+T6bgCjRbHCMWB7/Y1m
 VzTaILJOjq9q3m1j/nm5wcWYl47URVL1nlQAINisfytgPgFuk0WvKJfhk80HuRcanmg5XTNA=
X-Gm-Gg: AYBFou384GtUhd0ejQzyBhofG2NOM7JyRiX2Qk46UzG3xkSmZ54Ekp1f0SraoV550Jq
 ESYjg9MVXMsnr5qTixjfbxCZNFSb7lTsGrgGX+FcKPqM473LzdwMarGY9DevrgKyJAxNZJ7sqmg
 tQBBGM3wTrisYwc0W9U55+3CMUnTfeyAvNcl1hZheAZeFmNozcfjwUfJC406SMyH/Awd31PSoly
 snvLGhNi5eIFLgG8HmpWqrFmjSQx6lS0OxIURNVQB0r7q3rOc9WqwFtqH++WEOvfz3/uoXH3RgO
 4DKOvgHEZdrnzyy5/EEK8WKkaU/fiG7ce/a1oNQuqCr2Zg/js0nAw1oKpDUFGUC5MsQKGi3CmrD
 fu0ntDt8+vc6mWvyTyzostdYsBsnpfxYG3bPyXJZ0HO25ehVNPutRy8Wi04QopuIaeUfWGHHa9n
 A4B+K4qg6FxVK5xDvFZ7HWO9gZSf8=
X-Received: by 2002:a05:701b:2605:b0:13e:5a50:1e17 with SMTP id
 a92af1059eb24-16a55487e53mr24598204c88.3.1791996712695; 
 Wed, 14 Oct 2026 09:51:52 -0700 (PDT)
X-Received: by 2002:a05:701b:2605:b0:13e:5a50:1e17 with SMTP id
 a92af1059eb24-16a55487e53mr24598153c88.3.1791996712006; 
 Wed, 14 Oct 2026 09:51:52 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1dd57d0sm48975894c88.8.2026.10.14.09.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:51:51 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 22:21:00 +0530
Subject: [PATCH v8 6/8] arch: arm: dts: remove Lemans EVK override DTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-snagboot-v8-6-7caef86562b7@oss.qualcomm.com>
References: <20261014-snagboot-v8-0-7caef86562b7@oss.qualcomm.com>
In-Reply-To: <20261014-snagboot-v8-0-7caef86562b7@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791996669; l=1412;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=RlBhEl/QgjRmR/ppAjn1yX+sHTrgAqgvlHLzGSElyOM=;
 b=QoSfHP4Fn5WPyzJWLWIlqbB+uTkTj9m9mIqrE2eFAlTEjHBcMDYErQ1whgVJlf9Fp3xI6lC4t
 rCcDZA6K1pFCGphimNUXf2ZXMz3D++Bc6YtTs24FOX+5Zvu8A/TaAti
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: UG7kuZnlpbKIhSiSD9JsjtIEVcoD9FFK
X-Proofpoint-GUID: UG7kuZnlpbKIhSiSD9JsjtIEVcoD9FFK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX+dNT63PNrHhw
 Nu3LbJWaHCfB0jHITlqNI2nWBvoaFJx2QLjlzpJPPEOJWJ2c7kh/biqBA+tHEisiTLUT9Ewex8n
 8oQ+091csoOVU2nnRdsUKH3g1VRo5DQ=
X-Authority-Analysis: v=2.4 cv=NctzRGD4 c=1 sm=1 tr=0 ts=6acfb329 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ZgaKLAyxbO7a4fke8goA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX5X9dnR5CKqtp
 2pcCyprULq5H04J1LbRq/6IDxH2DlS6jVOno+FG8M9x8jMmhls9kQ8N2nD4tQSRwCXTm3IEl/bm
 702MO0ohK7N5K0NqGybp/62LyRvD5QW5h4oXNWXkhuNgKRIKVQrHIjdqeN2F2Lm8V55OnMdrZl2
 VZr1N8RKNNojAnQNJFxCfUmYsgXPcsJscwqsZfeKyDr6CFOArJH4CyxZ9IaisE4NknI3Kol/fu0
 C3w6Nb4mok+UqvgfsjM4dU/EpJ4e1ruFvHQFx3wvxxyh4rqtOFADwSrabaobktvizlw98Tzy/F7
 KjrRuTjSGPYnFgUtUXFULkAmirSSgswmh6L+MYYVsrJ9oeOzuSTXFVjblLpkuOySxmGiTdbqgTy
 J1mT8AgR9deZgzzvUwdEE7FH+H2rX8M1Aq3t6/iYhNY7wQF9Qau5fiGoDGEvAFwEd27CB/vIzup
 5QX2zJb8KPLShcGZYDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140067
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

Remove Lemans EVK override dtsi: arch/arm/dts/lemans-evk-u-boot.dtsi
provided the following SMEM modernize series is picked:
https://lore.kernel.org/u-boot/20260618-b4-modernise-smem-v3-0-472391477988@linaro.org/

Memory node is not required as we can read the memory info from SMEM.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- No changes

Changes in v5:
- No changes

Changes in v4:
- Newly added in v4
---
 arch/arm/dts/lemans-evk-u-boot.dtsi | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/arm/dts/lemans-evk-u-boot.dtsi b/arch/arm/dts/lemans-evk-u-boot.dtsi
deleted file mode 100644
index cdd3d32f61a..00000000000
--- a/arch/arm/dts/lemans-evk-u-boot.dtsi
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: BSD-3-Clause
-/*
- * Copyright (c) 2026, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-/ {
-	/* Will be removed when bootloader updates later */
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0x0 0x3ee00000>,
-		      <0x0 0xc0000000 0x0 0x0fd00000>,
-		      <0xD 0x00000000 0x2 0x54100000>,
-		      <0xA 0x80000000 0x1 0x80000000>,
-		      <0x9 0x00000000 0x1 0x80000000>,
-		      <0x1 0x00000000 0x3 0x00000000>,
-		      <0x0 0xd0000000 0x0 0x01900000>,
-		      <0x0 0xd3500000 0x0 0x2cb00000>;
-	};
-};

-- 
2.34.1

