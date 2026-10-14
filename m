Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188D2C3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCCF980E62;
	Wed, 14 Oct 2026 16:51:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id peMdl_W0PYw5; Wed, 14 Oct 2026 16:51:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 13F2B80E4E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791996703;
	b=K23nyWJ7VMwZ7F/oh+RZHJw/tLrs1+72esfx5AqAT0k3ITfukfKP9Sue/NhvXL4zgoVq
	 xnC7v87+49FZJ9G8zsz8JWi9+rjfpV5TUCSGjGSPZb+q7Amh9F5pQJn3p6MhVHsFfHNnP
	 JEKil+8UuL1ZdnF90N8VqPDlrbrQxmHVa1eptUCgZkLeFAEZ8r9sKaDOB4edtctidf+he
	 Rpj5C12rFb5emtXDwtrRUY3RNlNxG0LUxUmSOmIR3mppXGeAwKfosCnCIigROMdhB5DEn
	 gbU3Zm3xhaNopJXjrBcIwN+uHDUEbQT89lZ2aShLj+mFKAzRq0Q3YrjaknrrQd7lnnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791996703;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eg9r2ojAFoYBAyWlHUgAfB/IExsUzAsGpuK5TGL0crI=;
	b=oCqWyQC/QDvjT6eaI1TT1M3C5xn5gM6QXXhP7FVVDNO/VwfwziGN0/8s6wMiiV7WgOxt
	 3EePDJzvm9vDSCXAV1UfrHVG4NaB4qj670HE8h6cBvXiltT10iskBymbVysAGhGnKikN2
	 KIwvQ5BDzALZVqrBEslO5KAVpIlky2tal+yoCCOEhT1dMPSWGacGcenvGdc4WKPbid1HI
	 F9jxFcXZpYk+zPNAxduiZkmeB5K2PzgeiN4VSBCcb8ur2nQoTHaInWwziut7nMWadVnlh
	 VHQ/PZBDHINOP40z18IKJc2vc2Ihgv52PNCq4UKHS5LKSt9IK+k4ViUIdfQBnipqI7Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791996703;
	bh=eg9r2ojAFoYBAyWlHUgAfB/IExsUzAsGpuK5TGL0crI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h278D6fEj6sHBSLXhetX3KC6+3Du2tuiFKaecDQVi/op+ECF7Hhm8IqPqweF3c0v3
	 AojUn1z1ElTNqZU/do/DpoECXsQ94a3nJjfdaTZvVUHrb7denvy0a6fsIdhioJxNyQ
	 UBy1wzPu0XbM0TI/14cEcMzGtm2msyX86mP3dSBFYxl2CSoEZvad+/LmhyPecLbusL
	 RvsPS16pPQWTZOneZb8upqZhlChO5ENzA5Gsflx2VNXFQAzMKui2HyG3lQ87DBRV83
	 /c1rI6PSKGiZyQns4n0ad1rPXF4/LRRWmnTZDhpmur+mrFcj3C83cznkwET98gW6y9
	 dX5y0UGa0+3nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13F2B80E4E;
	Wed, 14 Oct 2026 16:51:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 634C44DD
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54CD44036E
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z2HiIbh9cq_W for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:51:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9A7A7401A3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791996701;
 b=ZY5CUnwWwp+3ypA2ljHAoMBtkmWJiREwtVghfhEFZEdzOtfrhVYlXZpJH3+lwTZLnPEh
 aV0rJnuDTGq9nbeniAuXbdgpaytsBJWI81psQxwo5GgO8h45H1PRVbSg0LdZtWT0pW+9j
 KyImSr6MXE5jrmONAhUEWSHHW5uWIMLcVRzM7wyvCI487lynK3Q/XY4bcPWqplVJmZ79l
 EDXZ/xR0iZIOFBycpqWbPTs+l6AJrqOrZdMc0Y54dS4pYqCeVC69k2P4/Ur+Qd5TTlfIj
 nr6joCmIu7UTgPfZ0gEnRpdO7+BvjXH3QwJwgMDha8GLcH9zh46BTDuDiiqy6BKCJ1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791996701;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=eg9r2ojAFoYBAyWlHUgAfB/IExsUzAsGpuK5TGL0crI=;
 b=PCMXH2NhRqJ0IM+D108M6TwgeeOLtveXmaMlTryx1uSxf4682erltBt3HxeJV0UvD5bK
 NfWfGQKtot6XhvLxZfkAUM3NLUSD7RG7Odqkcxj4RXMM+mVDT351lqqDgRL2Wvh8dQuCu
 SnMtdhDrJesblO3mkS+KjhBsFkzIOW4Gjrizk1s8CgWuD0E2pAT3JhARQ2xdg+RJsThfn
 n+eaQJnv7/IrtPSaCEAw0U+q/7l82Crqc7CsARR5oy/nUnTa0RkMFuS48c3idV6wv1LnS
 UZi3AorlzLKG9u/WfQChUQ/v/bkjnLKW0O6NrELMBb+qSf7+cqJjdw5r2vgsqXsjVMw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="GB7E+O/a"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FaDHI7hs; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=GB7E+O/a; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FaDHI7hs
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9A7A7401A3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:40 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEb08L905393
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eg9r2ojAFoYBAyWlHUgAfB/IExsUzAsGpuK5TGL0crI=; b=GB7E+O/ab5t8WUYu
 YeIDkyZ8Eqys5/T6drwXxONGk2tc+xoRgpXBbSDGTETKEWhSIll1T4vKUxrQ26uq
 Hnxmppnm3aHXUEIrt14Xqj5jIdIJKrQAmU5hBajQE/z4eCpTnoAwB88leP4uD7uF
 imCI5GhPj2OLCM9Qw8waCHcw3xFSukw/NM1Ro48rPw6fiz4jvNTwo/M5Pkhkvp/g
 Lhf3vpI/sC50ZSxBLrn9C5peqcs7j3ZSA4rl9+YU/AJA+gBJfirjJpzOLTmgDc0t
 UtUwINxzOM9JNSulTIYjCCC+v7RFo7/ql6MaPgXp9SNJNTJQFMgSufF3W3QqfHM8
 hB1GeA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p2n5r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:51:39 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-149e8e8ad71so4717716c88.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791996699; x=1792601499;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eg9r2ojAFoYBAyWlHUgAfB/IExsUzAsGpuK5TGL0crI=;
 b=FaDHI7hs5gKQIk6rTg7vckXWDT7N+QQb11ll07TJx/Y3lSPQk2QZS6t62MsdEZx6lr
 o49wGMODORlmyfl2AqZZzKiJ2ikH6vnH9S1eGCsFoyPkoURJ9knecJRa4Pk4WUNsRH2Q
 nITDdjJGVNZQI1xKc8CS62KS1yYweP98jTkKlQm8EaMRzt46jBNUUicnjmwUYDl6LYfc
 faf7SD2TXY3aT+0wwCM5uboDxQJAcwyS4LZtYxGBlFSAryoM5RnHEpEpjPNO4bAVW4uD
 W3esiIvxYH46zjQ2xfEZl2Zlyd0+6eSaB+6LyMSurFXOve4hA8p6hkxC4an7KBv6+zlC
 IJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996699; x=1792601499;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eg9r2ojAFoYBAyWlHUgAfB/IExsUzAsGpuK5TGL0crI=;
 b=S4Fp0RVJpZfetuIH0Hic6oEpM6Zc3aujvN5U0josVo20E5daQyBldp0VEthG9dBTlS
 4aKW7aL+TvX7jweGhVDtTGrFOaXrcrNQRktOIFQYUzcQJablcgEcBH9v4/tRoAfYGvCK
 CWEarrFuo7GPKkghMdRrSRS135wslOX5sSQ0KqwgYQulJz+fhozFS2Xmu0F8l3/dRAJw
 7eHE1aY1ZQFPauyEaLomweUBiO7tJo3jF+W5/7fkojOiKJcvVkGcbMCd5dm65oBKgGHf
 F7XKWRGsc4qTfC/TsDIhNb49W7OjPEvpHOXl77tUnP+8ZSlthfaVCZUgR2mkF2Uyyeq+
 b0UA==
X-Gm-Message-State: AFq9FYKYt2ngrSikPYmyJJmmOnuCfkrx1mEmR/MNaJVKGvMUYn1rGQhi
 typJXo4QtT3EKTsm1HNG5Yi9OMd4RbttI752bLjcqiwdIcOeh3JVZkX7CN1tk73j6PbRJWQn1Vo
 GALTRLEqPIwAh0+b3nIRpiV019EG8rPYZLtDqgTp4IC0tbp82lvBU9YaoaO0vUARelVz/TQ2mfG
 3+VMc=
X-Gm-Gg: AYBFou0ub3KFzJvYYTyIL3Cwnab63r16R7LwKt71ezNJ6fHyo11LiMNhurqXiEoFbGw
 c5bcESUXE1em/HpJnThJYu5a8zAYLYeuNJRCVUDyuoI1sUsZe33RjWzLabBK+lQS7v08XsbYiV2
 B3JA7i/VKcCXbEUS0vMdYzTVDzYBy77Wg59UZMhLqdh5IWv/zEOZ1E7NhHQd7kfzWL1RJ8kUxRW
 o0sVflqs4GTBfW8gCGfZWF6jNVQ+dJ65+/RtzYfTeF78lFAabjZzj79E2b0+fM2GD+/mTaGAnpX
 Q2o6Klyk7mnNFQ51HrizmyXmjBnrxpBcRIWKqMqvEhHICBbSpk0QspEMrVhVEZjgsXE3pDe3Uks
 BMD7oQTn3IXwMTGvUYp+CswZyPHjLm1GlHL9MVTsGM3ef7JBrOQFPNegoqjecZ/3bxtfuux3NY4
 q6CBcQ/s1Hd8WSJcgGe2vOqji5Xsc=
X-Received: by 2002:a05:7022:3a8a:b0:164:ae59:935 with SMTP id
 a92af1059eb24-17572eb515dmr12693941c88.34.1791996698564; 
 Wed, 14 Oct 2026 09:51:38 -0700 (PDT)
X-Received: by 2002:a05:7022:3a8a:b0:164:ae59:935 with SMTP id
 a92af1059eb24-17572eb515dmr12693903c88.34.1791996698057; 
 Wed, 14 Oct 2026 09:51:38 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1dd57d0sm48975894c88.8.2026.10.14.09.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:51:37 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 22:20:58 +0530
Subject: [PATCH v8 4/8] arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_MODE option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-snagboot-v8-4-7caef86562b7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791996669; l=2033;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=qLdprNDhOi9V9pcY+jz841++7Y3Y0V/PMAuRJ97cSUQ=;
 b=6wzHbAL+FJraRxrl9ze4FJPvwRK+EDuywjcQ1gW2yRKbUISBD7TNOE9qsD/r+mjFxaTGX0NKz
 oVHHF/6rJpXCVlRtkm0wS+CKI7KpKIK4YHDBHmDcnopDbZ7uH/ILjCs
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfXx1vXExngteU4
 Sssy0ic63cdInYQueI3dxiT+LEcEOcdmOpY44RM3b8qsDWZYtopSe7UnpvGJkFhocCOs9udoJwl
 dgqBKj3CwBXs7uAK5Lw9EGfvD5W5+rM=
X-Proofpoint-ORIG-GUID: UwHNORQxjGoLiVws997qbc2T7DpmGt08
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6acfb31b cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ZHSanarjU4c6-wJI9dcA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX3XyHTOlUfPkq
 JfF1Gr94OX95CfCI74DFjY5xLh/0E7VyoSVaMyyZQBYBayZWyu4xdQF8Hs+YIoLpJf0DfB/N69J
 XG9Qo7iZXcyzmQ6BjnVmqeB1b7i2byRm/r6Zo/9S21Dv859KgM07tPBKUSrw7t11TwWX1zxqpQ7
 3Ppdo4Vr4u1/HZLf7g1eVB+aPuldsGP146y9W6maTW4tn2e91K4JuEnDFpQ8xdm5NhnVNw/tUTK
 DUnasTKSFfkZgvAbCysAPXUASZ/0+PmizMh0bSYwdRJz6oYGi4ue/mbpBBAr9nIW6bFzvGdxumE
 NJPxVUW1qMgnPWkATy0hOTJwVoiqfJw4uV6Ugi4Ab3DchS2ejS30Vzn+U8Ra0Ilc8huT+ZWf8Rr
 4Qkf11OFjAX14Or2RIRTTLNcC5iuKJtvmi83f3C+qNZUoDTyLKnS/gRidchCkRHmgjgIGBQzlsN
 hIjFzKu/1B2Z35EEOqQ==
X-Proofpoint-GUID: UwHNORQxjGoLiVws997qbc2T7DpmGt08
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140067
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

Add CONFIG_QCOM_SNAGBOOT_MODE to enable snagboot mode on Qualcomm
platforms. This config automatically selects the required dependencies.
Express the platform-specific requirements and configs that must be
selected and disabled in snagboot mode.

Add QCOM_BOOT0_SNAGBOOT_MODE as a hidden boot0.h config, selected
automatically by QCOM_SNAGBOOT_MODE. This boot0.h config is for
disabling MMU at the start of U-Boot execution.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v7:
- No changes

Changes in v5:
- Made QCOM_BOOT0_SNAGBOOT_MODE dependent on QCOM_SNAGBOOT_MODE so
  it is not exposed to users
- Add dependencies for QCOM_SNAGBOOT_MODE explicitly as "depends"

Changes in v4:
- Renamed QCOM_SNAGBOOT_SUPPORT to QCOM_SNAGBOOT_MODE
- Added QCOM_BOOT0_SNAGBOOT_MODE for boot0.h which gets selected by
  QCOM_SNAGBOOT_MODE
- Document the platform-specific requirements and configs that must be
  disabled in snagboot mode.

Changes in v3:
- Newly introduced in v3
---
 arch/arm/mach-snapdragon/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index ddded0029ef..237395e1d6a 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -82,4 +82,24 @@ config BOOT0_SDM845_WORKAROUND
 
 endchoice
 
+config QCOM_BOOT0_SNAGBOOT_MODE
+	bool
+	depends on QCOM_SNAGBOOT_MODE
+
+config QCOM_SNAGBOOT_MODE
+	bool "Build U-Boot for Snagboot mode loading"
+	select QCOM_BOOT0_SNAGBOOT_MODE
+	select ENABLE_ARM_SOC_BOOT0_HOOK
+	select SKIP_RELOCATE
+	select ENV_IS_NOWHERE
+	depends on !ENV_IS_IN_SCSI
+	depends on !PSCI_RESET
+	depends on !IOMMU
+	depends on !SAVE_PREV_BL_INITRAMFS_START_ADDR
+	depends on COUNTER_FREQUENCY != 0
+	depends on TEXT_BASE != 0
+	help
+	  Build U-Boot to be loaded in Snagboot mode on Qualcomm platforms
+	  for device/factory provisioning using fastboot.
+
 endif

-- 
2.34.1

