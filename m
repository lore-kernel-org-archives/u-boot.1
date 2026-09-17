Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26131C982D0
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 09:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFD5E60840;
	Thu, 17 Sep 2026 09:15:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CX3lFsgGlJY4; Thu, 17 Sep 2026 09:15:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D3FC46082E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789636557;
	b=Mk7kQWL+QCL+ADcW+lcYNF7axog0seavdZ2xtydfT/RIjk/XlDYJr6xhMZkKGQxa2Fhp
	 RSCqJtaJslmxHtxkwDNEwOboQis5GNY1jvBBKca3RWv4MkV/mJJXPre9Qs8Xt9Jsijnu2
	 N7lDSF/w/wwXmQuaJgJzEMxUDDKfrBo9JzgntOUSv0SU+JJWsYfP2hNiwZ1DjxZpsr0s/
	 PnAkt0oz5s5vzgJTHmQAS3sipZAXklCZlxPhaXNjEjybTxFzt6qExVzlqfvxV3vUztBKj
	 ifuPqCfDJ2w8myP3HYyjmfrfv3qEZzLUsnhSNcuRoHlRpO2KOwoT1WjefMRGlZIJ0HA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789636557;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5s4qYZuj7WTffYSUh31hhlCeZTOASJg8yBrdw0GdNUY=;
	b=mArqTa3Xkl4GlU6J1nKxhZ6nCzRL3tgZWJa5YTd3j/DzcsyqhXOHqlAn9ht2oCkjR9bw
	 1BzOOPLOjqVITX70jMGll2RsN1xHNu3n7JDgmw+djbhJlKrmk1pqkymw2pTus+R66nLWP
	 x3AeelZiH7IggVMqeIcomOfpF/5UBVn4CZJQbjg90OTSHGdJUy7CX+jMFVvU9qYWIUO1E
	 NSj7JLQiCkf2A9S7vEYhHMT9TQ1PW9Bj+Xwi0UP+NSJ1AfQW7KOlhGyfHR8bs/GCzaGVf
	 pntkOfePYo7V0p02k8Pzl1l4klB/oC1wnXu9KF1pXBuYUaanZ6vwu0umImrmDVLdbsw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789636557;
	bh=5s4qYZuj7WTffYSUh31hhlCeZTOASJg8yBrdw0GdNUY=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ziPIWiRn1xUnSAvDZqmglX4e1XIgk/25nOBIqSdofBLW9eHsVSqBdFjGcC5RGaPOh
	 8tKk9FMkZ9b3ZYtYnhKBN9Per1DtE1SN/UfKlLZImipy+CWTq7stAkPZmtZqmOh6jz
	 9nlQVIE7a6fo81oW1jkk1x48qNIm1U1rBs5ctpdn6k0fkvkE+6zJpPWlNcaIYhUz1N
	 hWoGSE4dfCRGWZ2Uu0YDca+k2aXtp5W7Ko1gAkKsSv7Tl2fPQ1d+/ljkodFFXHHxIO
	 teUe1S+xvF0oSAHwh70BJFB12pcYk227uoXPxw3tDP40en4pTEd96chhUEXKtHpwNE
	 JvK/i0D6tmrnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3FC46082E;
	Thu, 17 Sep 2026 09:15:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E38CD362
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C9787401F2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:15:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ABFi6IHGmXB for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 09:15:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org CE75B400F3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789636554;
 b=kEF9NaTA4K0mkiYqQLgIImwUiD5inTQSPm7tiqZajtqOS0CymX5CLtdKk4yE9JPItPcJ
 892/FTEstM4w/RzrRCWX+swd0bUhe73AD9GehVWbQviS2g65gj4KBuAKp5TTKF2q5Jioz
 OwSXt4zbY2nusizWs11R5nsz90+FuZFmAkjPE63S3z79QUwHApUTQ9DKp+UQThfKI/sJi
 kNrEodfKBWJv7k07Qx3y/8i1RozE1EMkNzT5oKXObVCFrFdkkJVNErgI5M6U7MEoV4wuG
 TeeOzkUjN7Zojc2ptCaHxHLp2xS8h8qlGRpRyCOBkfe4oWylsuxy/Dtr/si7NRGMB5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789636554;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=5s4qYZuj7WTffYSUh31hhlCeZTOASJg8yBrdw0GdNUY=;
 b=FBm7269mJgoPoO0Hlqt+RdKQ/H5d80qeY2PrTp0uZ0s11uPsALVwOIYZSNmKHM+sIeBZ
 DmRH1OSk7hNc6KDWboL+525eDf3RpM/10OOO3+HD6DXS5Dk2hKrNDXNzU4+c2CPVPALQE
 qUbc1KHAIWlVKaO2FsAH/FNrXp3yglFLgdSLaoiu0nMIZ7ZnreU46dJhTV72eL/PZUiwC
 nzbX5smXg7J+qOjdFMZ1vbLhjO2kqevRnB2U3dLN72Ygu5+Sp8RH6OpIs42iTC85PrTEk
 zjB9K9XsTgroQwbYh+xGZqXWuFr+T6TT9D27BeDp7FnaMUSchIMsMzjwAe/cktvL0fg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="NCU/whc4"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QM+il0Yp; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=NCU/whc4; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QM+il0Yp
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE75B400F3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:15:51 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H605iY091628
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=5s4qYZuj7WTffYSUh31hhlCeZTOASJg8yBr
 dw0GdNUY=; b=NCU/whc4DSy9fAYQLBJNI2JFAyHMrKpVgvytwSRBOOrqIj1CxI/
 DXrOfZIinYmzH8oVj4LG1qS1hsifDii8mX+Wy5MfTjTxye8jLMpzmuFqA4rj5UTI
 2FSp4rGuqH6AP/XTeSJw6IsQG7QtQzRj3XixbxvWxmthlt6suZaqhV5l5IvcQ7Sn
 FmcOjQI4zq+aQex9MXxbVAOfUaGCsFfdbGK463n3QIJK0HgtpkGDc84HUJekb1tK
 q9AgoJNIGtYWBKxJfujQriY0qTw8N8NUKJQfsVdq8DlKvzbTseNLeHMvwQS1+zLH
 0FS9XxOxKTEZrxb7+4TlCmaco2u1dqL3T+w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gr8uw150r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:15:50 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39de1f85cb2so921324a91.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 02:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789636550; x=1790241350;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5s4qYZuj7WTffYSUh31hhlCeZTOASJg8yBrdw0GdNUY=;
 b=QM+il0Yp/hBx2QlOhKudwfcrYuXN1tsZEDXTdi9ECUSKrAUzUA8Y1HodCwsozFkiFv
 EhKKPMRpBBEWpCcv8YsBOGhb4QAdgGPScVMH9hLmgG7KN7a/d+CIsi5MpY0agWZisLwt
 JRpztKPHLYt+6FJFIZULaM/6y3VgmR7fa9mrt5yAgtUsLzG5HpNMPCVvv2lGyu5AEl0F
 wcyyyuKlauyFmeHF6QOqX0qfvMoypATZzejcJtoLA+UPeatNkF2x2IJSJBuN9KhGxYhl
 2KmmUfjyeoNYdU+uOm/8ti0oodOLstqzxdMOtQoyBxu8t6WcOVQjqs1nY+j8eHjFxtGX
 woNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789636550; x=1790241350;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5s4qYZuj7WTffYSUh31hhlCeZTOASJg8yBrdw0GdNUY=;
 b=Eg2Z4KDYoDg+ChYacgVtTBKHbpNt44Dnas4pYljIhKipwbPQurnMT5VDrhEagg/Pjw
 pxhsgaz7Ax7/K8o0sTF2WvuiVrwua6ah8TqYrCNhNEXYfdnOpsIE7i/0ZfodzKiywgi2
 o74pbxik/8ou2BbCo/OfwuG0HAK8Rp+fk3TYH0b79HsTQRoD0R5tbiNCLqMwFDcaJG1A
 kDE2DGE/SQzHWCMCbQeCFHtfFdikmeVb3XEKr4fOEULljv3eTDtxX2fongFrJL7yZTV2
 5dudmEsbiDWvYsLWaFT0XL1I375wjTqRXvqe6NuTaSueFnxCUnvUAsOkTEyy8ca97Vvp
 Zz5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBza0eQ4i1joi0PICh0f1eky7Z9XYkvo8EVVbckqbrOXNLm6XtnEaZs5oYiR9LkUjWtqf77bylY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m3X7BjNbgH0CBxFur7mf2IT5vU9/ZQ3Ct5ml3XFrvrGHtLU2nl
 fJwIQVnk6+Jn81el7tI/4MJyxLS9gkEL3Ejc+xCRkJR13APgDHQF0oOtwlRwTLNv/0jQy+pdqwH
 QeJq94zOqUokyMlpvPkTQKuomL4HcYosAEFRI1B5VvZYQVzii9jguhueImux3t3zIZ/yzTUo=
X-Gm-Gg: AYBFou0/SphWkUePpHxGVOCEJZ1poqB6XQ97UxCBMG/9yR05QOxfWhoh9S7H5EGqj4z
 tmqPYy1Q+HLH+W9FMRZUceSgWczOU63HR4DndEIhoafRkbzVCK26rnk2HSimfGHDitpnPqIXe1r
 0yGG8xkORaDtqAOUqfdoEID3jMxJMnk2jAtlw7yNzofaPUt0BGAMy7HTAnowyLxISsxHi7GXfLU
 QXQqC4pj2uJalxo6b0nJ7EeVp4cYSmk/MTOgcipMwlxVrZd4Uf12s583OvY3wUt5wnFefTw0T8X
 CWHokV6SBtYPh/gG5UlgE+p/v0AZqCAY/lOn5MpDTE4UQuTrAJxtWHeOF9bh30H7X2tPyw5DkfQ
 7InBEduL242qrnbnwEgxCgOOjeuW31XoVTX4soWDpx93yNkLfpomHD/EbGGP+OGvCDkqiWVnvt2
 EXBsyZKJveqBBCP2uSPJE=
X-Received: by 2002:a17:90b:3c11:b0:39d:efa9:cd1a with SMTP id
 98e67ed59e1d1-39e1e2655e6mr14153838a91.4.1789636549851; 
 Thu, 17 Sep 2026 02:15:49 -0700 (PDT)
X-Received: by 2002:a17:90b:3c11:b0:39d:efa9:cd1a with SMTP id
 98e67ed59e1d1-39e1e2655e6mr14153801a91.4.1789636549445; 
 Thu, 17 Sep 2026 02:15:49 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c19424994sm625646eec.12.2026.09.17.02.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:15:49 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 Michael.Srba@seznam.cz, aswin.murugan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v1] mach-snapdragon: page-align reserved-memory regions
Date: Thu, 17 Sep 2026 14:45:38 +0530
Message-Id: <20260917091538.4148095-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UWH1grRZaYEJA54PuOescG9w_prSAbFa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEyNiBTYWx0ZWRfX6dAnWbRi+DR4
 do8XWOa5sS3o6JFMKJLdcADq9yKQR8J8p/k2zPOOLQGu130EY0BHlYh4fns1H3BovbwVM6mmezs
 SJCc9MnAIUUA53AaT1VMaUBjG6NGVaT8DY9IU0EtgvnNXRxSASvxLxdyNY18+BvQH9DcSzDVofO
 gzpDRLGoYOXzMBS6xIG1qHOUq3judL+yFaKnSTK4x6IG6/d/WYJNeUh2I8m5MZ5R4nX8Jogx3KM
 L1WQkDVAh9RvxgS7cJT46hGnzPhVk10HEG7MyaAMqrBE/2/WXfhE6fgxPgtmuXYh7HuVlsQJ9X5
 HtNzE0hLCmkEXOI9Ecs++MdjogajOunjbJOOM6JULlzWNSolXqN5NTyyVOExSkoSrlzaM6RxPsk
 OrnNP/UDw8NW8GfUfqmrhjtX3s1fDE4ArBh7cApLEK7C92f5IqvS7Ij74P7dtRCKl85TPLVzwZG
 gWHwN9pzxhrcij9aNxQ==
X-Proofpoint-GUID: UWH1grRZaYEJA54PuOescG9w_prSAbFa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEyNiBTYWx0ZWRfX1eF6G8PO1VXX
 ebYoajo/+k6rF+rxtjgkJQHmst+24dDeBOaXK3YsdkzSqZiJkjA9bShCy2ZplsdiNoX/35OQf16
 UUopHwuZ3tO9UgcYDJZ+MHJKd+6A1qQ=
X-Authority-Analysis: v=2.4 cv=dMUzC+Zb c=1 sm=1 tr=0 ts=6aabafc6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=MRssP7E6MZkipdAuXCUA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170126
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

mmu_change_region_attr_nobreak() operates at page granularity and
cannot handle sub-page reserved-memory regions. Align reserved
regions to page boundaries before updating their attributes.

Also increase N_RESERVED_REGIONS to accommodate newer SoCs

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
This change requires the patch series [1] to be applied first.

[1] https://lore.kernel.org/u-boot/20260521-qcom_spl-v9-0-c108ebe8ff4e@seznam.cz/
---
 arch/arm/mach-snapdragon/mem_map.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-snapdragon/mem_map.c b/arch/arm/mach-snapdragon/mem_map.c
index f64ec0c674e..2718d7f280e 100644
--- a/arch/arm/mach-snapdragon/mem_map.c
+++ b/arch/arm/mach-snapdragon/mem_map.c
@@ -83,7 +83,7 @@ static int fdt_cmp_res(const void *v1, const void *v2)
 	return res1->start - res2->start;
 }
 
-#define N_RESERVED_REGIONS 64
+#define N_RESERVED_REGIONS 256
 
 /* Map and unmap reserved memory regions as appropriate.
  * Mark all no-map regions as PTE_TYPE_FAULT to prevent speculative access.
@@ -131,11 +131,21 @@ static void configure_reserved_memory(void)
 		 */
 		ptr = fdt_getprop(gd->fdt_blob, rmem, "reg", NULL);
 		if (ptr) {
-			/* Qualcomm devices use #address/size-cells = <2> but all reserved regions are within
-			 * the 32-bit address space. So we can cheat here for speed.
+			u64 rstart, rend;
+
+			/* Qualcomm devices use #address/size-cells = <2>. Reserved regions
+			 * are within the 32-bit space, so the low cells hold addr/size.
+			 */
+			rstart = fdt32_to_cpu(ptr[1]);
+			rend = rstart + fdt32_to_cpu(ptr[3]);
+
+			/* The MMU works at page (4K) granularity: mmu_change_region_attr_nobreak()
+			 * cannot map a sub-page region and would spin forever on one.
+			 * so reserved-memory regions must be expanded to page boundaries before
+			 * their attributes are updated.
 			 */
-			res[i].start = fdt32_to_cpu(ptr[1]);
-			res[i].size = fdt32_to_cpu(ptr[3]);
+			res[i].start = rstart & ~((u64)SZ_4K - 1);
+			res[i].size = ALIGN(rend, SZ_4K) - res[i].start;
 			res[i].attrs = attrs;
 			i++;
 		}
-- 
2.34.1

