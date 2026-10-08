Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4FECA600E
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 09:49:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2AA381275;
	Thu,  8 Oct 2026 09:49:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1nFMee3B_TD0; Thu,  8 Oct 2026 09:49:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B51F081250
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791452985;
	b=GDPVB3QaYn/xRLvwRFbDXteraLBPT4ugcRrOZ08jiKuFT5fge5kAk4WXCM2PAZSWIByM
	 Y+k8mqD2aFSh7gZct3aBdyFSzm3gU/AkBOjgyGmEx82KNVCyElSrNO+5LPxHHihmNpM0b
	 7crxJA1DLSCzo8j3lGdFG2jhgAQBNtv38LwPTj2G2vSyXlH3w1ybons41ZRmzc1GMuUk1
	 IYd03UEnyEnTgbB98Ri5p5sLTz0SjqkhHqDvw6yAfxPksuRMRStYABEqqHx7VZvbbqdrQ
	 IWs/e327r+Aw2KSJKGOiSyZxey6O8L/m0oetl8gtuHRBqn/Z70rTyi9xz8YxUBsKpIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791452985;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zH0KMzquOCu45yk9DRvJaDKdjUZVIhhoXDbnZB9TeZ0=;
	b=hszOR6IlSJUUBk+xEdkz9OQ1fnf8fffke9uU2uE2M8jAOX0wpHvYIPVIrtF2eZLN4ErI
	 3cXWguHrkQN1hLY5oQSA0rBEofDPJvew+PHIqVscJT6pR9oK/4+Qo9NPTNJwBVoUkjccT
	 ZoHmcGmq//qXnH137/lzmoura0ZlHiagHcU/1wH8m73NawZwwKAui3WTjB3X6xn+1NkKu
	 1HRsw9WyhpGHkgClbu+OcXuNKHYFq4h5OxjZq8wt70gk719UAEBfpI69rCvopRgNEG2sd
	 kIaEQi9UgY6R3jzYWfsZ8GvWKmZqIKA1S4iiMkM3HLy8+7mcEXxtYNOiRJ0WdJkeePg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791452985;
	bh=zH0KMzquOCu45yk9DRvJaDKdjUZVIhhoXDbnZB9TeZ0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j/oqO7hYGFG/nx5qE+tNwBORtsOfvAxy9br0K5vL4/gGVyPvaNNoa4xzE5a7PSVAv
	 svM+4p03oGyzzHdNjghMdQNMdOgt8Bw8ZhXtGRl8xezf8eIyUVCrelZQL7+rdhMdoX
	 j2/Nz+9kPjCQL5+WYKvRnJBObU7ghqBzRrqjG+5BMsY3Uf0GJTsyT962wKE1oV18QK
	 LxD10XYkbO/RpkXDnZ7sweFvyX79xn768ilCdGBVJtOd1xslYpXN2ZbrCRD8GOvjrf
	 VzuOVEOPktTvWpKUAXzDJrPy6oKWx7WRYBBa8smkNpwuTRaJfbXrreH4mI6yo4blws
	 nvCz+j+meMVwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B51F081250;
	Thu,  8 Oct 2026 09:49:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 533A934E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 393D560869
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EClGThvarzu8 for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 09:49:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7EE5F60817
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791452974;
 b=bYDqEK5f9S9Ybn9RWXCw/vJ5uNqUu0en4Alof0AZEOjklb7bNHJNhIRaKGWpUlGK8nY/
 UIhbt6nsY8PSPcODu+YITOj9gA9nyWSl2T6nWGRLEARd9PgMMDlQGLtxsgOJywYfRq91y
 7aERmd3pn8rsXwdi9ln83BxFMIEGOtRMLbYS7hBH56Ye1fr100YRtPex0KQ5gGHzrisPp
 AN9fGnGTWgDKH2XQVyWrlsFXezTrV83Uz3trSysujE+KPmOwSMbJu+vslgMw3vtoTqxQo
 DGEMvZTxgm1qkkyVwI7lDizONcWH0NGLaa2pesoslIbYE+y5Zx/C3GthXxi2/ZSvw8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791452974;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=zH0KMzquOCu45yk9DRvJaDKdjUZVIhhoXDbnZB9TeZ0=;
 b=ag8nxb48ZULnCxfK3PI6bOcvOa3rTUuT15q/8/DFiqwvvC21fJdVj3xiL5vTc3e4ARFK
 L+5L81W0ID6g6tnTqBUw4A6eeXr6QxIOZLN/VG00ftb8AMR/s56DHiQfaNoO+VHb6EJ5M
 s3IZ7r7u8l6dnIwEPScgcuMv68VD3nDt5WqyCGlJ3WOytkK9jH+YVtLtVpLnhR4V/6aEz
 b1ypALOr6KdwZ7Mye1t4h3tcatvU1qTOQFDxh2yG1ekS6q393rfqH4ls6qTxajfeYBkLg
 HiwiwhsBQ4W1vcM/8w/B3DV6E7U1GVZ/BiJg+TIzAyqoe31L+/9Mt4qlD/CIj3UBVeg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=L95v16jN; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eogLp28L; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=L95v16jN; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eogLp28L
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7EE5F60817
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:34 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987K3Zo1341763
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 09:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zH0KMzquOCu
 45yk9DRvJaDKdjUZVIhhoXDbnZB9TeZ0=; b=L95v16jN9XARag/C9rWM0WlIdZq
 n7ilBphz03kL/P2ckDi+TGwyZRvhv4lL8PJ16PjgUsJsymsir8ektJLbWfFLZJBF
 WPim1BwZAfsiLXkKg1fAcf6OviFTc/JAcmUBq7k0uVzg26caRq6x07e6wcv90akq
 EiMQ4AhPUoMHJ7ZIVeTweWA//ugJk0f8csjovBlOYrH/NLb0EaduiHd09VmlBakH
 uDdWD8PYFIpaE42xj/Y96CU5Wlqkl426jh75dsWxNV/+5az+RpkapsL1SXPbc9vp
 Gh4Xodlj4uCaW3xsrj/Hx56XP7GBqK0GQbxUS+6eCSk+AnOTjhzpPu9DpXw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2t9y8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 09:49:33 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34d62bb27a1so21311207eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 02:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791452973; x=1792057773;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zH0KMzquOCu45yk9DRvJaDKdjUZVIhhoXDbnZB9TeZ0=;
 b=eogLp28L4vNNgZiN29wzVzTOJn3GMoA0PuXYiVgFWvUU6gW76e1HRJQXwlVXLJwTv2
 vLjEngmTaGB9py0axmphuDKUHXC9XwU0+e1a4R2Wkx6H1d1PugOqnFTUvLSoAtVEBH6A
 RkMK7ormBWqoJaW5Y88lP1v4sREeOYyWZUilonzG7+VnqGwD9pX+xd0TZgV1WiQmgbhm
 YjqXiZmxUuvyZNMFsGdt9xkAVvygel2YgZ+pwiqh5A7Uf88M8hK1rtR97hr+1Z6k2tHf
 cZWRTI5Egky9VwDCFiGUbpLjbf5JB5GpAtjoQIsCRsBp6RI7whUWYHHUhL9NEY7bhgE5
 kBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452973; x=1792057773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zH0KMzquOCu45yk9DRvJaDKdjUZVIhhoXDbnZB9TeZ0=;
 b=uc1l3FWIRcJLnlXl6Pw/HJnljW3jMo89mqp1BwUH1FR8IUJ9udsMiYYHvYPn6kfhih
 ruaCY6gfIoa9RecDRmaPF9pjWvG7I50N5tF88hzgY4uZ3ZaQo7K6iP+AgoJ6JlQ5JCzm
 naJdVq2rT6C2pkcoDbuz2Ld58L3MnWxbp/VKjxe+lreWvDzEAajfS7qiX+YqKv89pLI2
 +oe1Bkz9lCqSJngtu8bZqjY8XVLvttvCwQpxI2aMTKkmO+PoEP7/nfFrTo+eEa1Da1ZF
 /f2JnRkik7rGI18Zrn+O0AT3wmR5PeD6PHm0a2gr6KrwlotQQOu+Fjzngt0WYamx6cOB
 Fsbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBykCphH94QPgsoIIi0KMuivz6QPnefW/DzK/kn5hXwj5qBTul1J0oxBteDKt1SqVMl6sntG6fc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lpA8p+H5DzpRtWD1rjqFTZAhtV2s3ld3hb37XyI5b9Lx0T2cG8
 M3q3I5JOLNmy0J5tOeFtRr0KV6ZbK/8d/Gj0j70rWVEr+AKwg7QVSAPyHsda2QEr6jnDkGSVNq8
 Y1rUCC3UDrqtNUeDlrgBgvR4ay7d58Yli4Vf+nuqfZNAQYAumWG3jnPNNbVwQo3RHu48pHiQ=
X-Gm-Gg: AYBFou3CDLAkhvJR6ozUQi1da/j4VdAts9f6BlVKey1OZVDx/494Q70lB8IGHmta0HF
 I4Df1h+LkXsb9nqHuSyuEZ+QoABo5k7NlbQuWm8NLDO2U+Yu4hITm0ODsq6LiG0dti6DwI84uKf
 /S8eo6RNUFgMYG6kL8aM6fMlsCgVHDbRjHgvyfsLEw+HayacgBRP2lNJ3TtZItj339wGnUmU5pT
 dGMeEL+ymasX9HiJzsfKLM2jHLASWwB2yJr1e3desfdVj+AmFhekryUjXmVWz20J981zU2H8m+O
 R/af/STdKbTeGqnGgfHWbDm/geQgxDdSoFf2cjtHcd/rLEYvsD+6z1zglXFH8PwTcHR7pGSE/gl
 txOc/+yIppJvuzIS79IsZosO6zEehTG73L/sGK0npj90Y1zE=
X-Received: by 2002:a05:7022:28b:20b0:148:8aa2:91cb with SMTP id
 a92af1059eb24-16208809497mr6068441c88.30.1791452972483; 
 Thu, 08 Oct 2026 02:49:32 -0700 (PDT)
X-Received: by 2002:a05:7022:28b:20b0:148:8aa2:91cb with SMTP id
 a92af1059eb24-16208809497mr6068409c88.30.1791452971897; 
 Thu, 08 Oct 2026 02:49:31 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16375a1f898sm9977818c88.0.2026.10.08.02.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 02:49:31 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v4 10/13] board: qualcomm: shikra: prepare QUP firmware in SPL
Date: Thu,  8 Oct 2026 02:49:09 -0700
Message-Id: <20261008094912.419090-11-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
References: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfXwt6sApvee0GL
 Mzl/DtsfLWZO6DN2TirYnv2nm7D2qy1/n1vxVyaSXmT8appltpItaMESMxHv0nOoFk+tPH9e6k/
 JuasPyd8Eg7dwh2XrWeqoSpsctaSRBc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX3vhSIr3GqvuT
 DgpItWTFeDr/b+FYiPGToD2av367fWaAi1wVxQbwsnkTOCOa0LafiDiETxTvJVGQtV9kBjDKGlO
 B3i9dq6ZTRbDfRqvz5LAX7AyW6NYNb6bpdXjc81wwUfVe0Kgq71Y2y6BcSFDZZ+Ux7QHEn6QNmu
 9RmQUO7sgWG5LXOluOxDvuaPvA8NeAkVbvlyiGDx89jRKSBSZUpO9WgvUyL+njaqvzUmMHPe6NT
 +TIH0gqOHHKR40yC9aPA+ya9mVSiTC666M0sYQyZzXqPyLNmq/jHTBBNujPNMzv+MoBYIcwKwpE
 fqPGR6s4+OWxJYmCi/GOKGPTX343gZ2GWIY/JS4CasYnexqaq/9kY9KWjFMVZ72ICXv6lqzG5Z4
 6YL3qaHIDo559jDFa5QvfdVQHx8/fzM3GlGpaLtkiB0vYtlRNCFZLA14SYQisjBVb1lh8jLv0Yj
 HYjCRK/vlqcjxBoKIsg==
X-Proofpoint-ORIG-GUID: mRahPkdpamAS0X0B8anojd2K_W-TT6aN
X-Proofpoint-GUID: mRahPkdpamAS0X0B8anojd2K_W-TT6aN
X-Authority-Analysis: v=2.4 cv=CIm/zhrD c=1 sm=1 tr=0 ts=6ac7672d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=nMXrJebM6ccVpyDcoNQA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080038
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

Prepare QUP firmware support before serial-engine children
are probed during SPL initialization.

Enable QUP wrapper clocks before firmware detection.
Initialize the boot MMC before the last-stage init event.

This makes QUP firmware available from the boot medium.
Release the dynamic firmware buffer after children are
probed so SPL can reserve memory for the MMU page table.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 board/qualcomm/shikra/spl-shikra.c | 118 +++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
index 9c7068497de..091a2a49e09 100644
--- a/board/qualcomm/shikra/spl-shikra.c
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -3,6 +3,7 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <blk.h>
+#include <clk.h>
 #include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/sections.h>
@@ -16,6 +17,7 @@
 #include <malloc.h>
 #include <mach/qclib.h>
 #include <mach/spl.h>
+#include <mmc.h>
 #include <part.h>
 #include <spl.h>
 
@@ -148,6 +150,109 @@ enum {
 };
 
 #if defined(CONFIG_SPL_BUILD)
+/**
+ * shikra_prepare_qup_clocks() - Enable QUP wrapper clocks.
+ *
+ * Enable wrapper clocks before detecting the QUP firmware state.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int shikra_prepare_qup_clocks(void)
+{
+	struct clk_bulk clks;
+	struct uclass *uc;
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get(UCLASS_MISC, &uc);
+	if (ret)
+		return ret;
+
+	uclass_foreach_dev(dev, uc) {
+		if (!device_is_compatible(dev, "qcom,geni-se-qup"))
+			continue;
+
+		ret = clk_get_bulk(dev, &clks);
+		if (ret)
+			return ret;
+
+		ret = clk_enable_bulk(&clks);
+		if (ret)
+			clk_release_bulk(&clks);
+
+		return ret;
+	}
+
+	return -ENODEV;
+}
+
+/**
+ * shikra_prepare_boot_mmc() - Initialize the boot MMC device.
+ *
+ * Make the boot MMC device available before loading QUP firmware.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int shikra_prepare_boot_mmc(void)
+{
+	struct udevice *dev;
+	struct mmc *mmc;
+	u8 boot_device_cfg;
+	int seq, ret;
+
+	boot_device_cfg =
+		(readl(IPQ_SPL_BOOTCFG_REG_ADDR) & IPQ_SPL_BOOTCFG_DEV_MASK) >>
+		IPQ_SPL_BOOTCFG_DEV_SHFT;
+
+	switch (boot_device_cfg) {
+	case IPQ_SPL_BOOTCFG_DEV_MMC:
+		seq = 0;
+		break;
+	case IPQ_SPL_BOOTCFG_DEV_SD_EMMC:
+		seq = 1;
+		break;
+	default:
+		return 0;
+	}
+
+	ret = uclass_get_device_by_seq(UCLASS_MMC, seq, &dev);
+	if (ret)
+		return ret;
+
+	mmc = mmc_get_mmc_dev(dev);
+	if (!mmc)
+		return -ENODEV;
+
+	return mmc_init(mmc);
+}
+
+/**
+ * shikra_release_qupfw() - Free the QUP firmware buffer.
+ *
+ * Free the dynamic QUPFW buffer before allocating the MMU table.
+ */
+static void shikra_release_qupfw(void)
+{
+#if !IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
+	struct uclass *uc;
+	struct udevice *dev;
+	void *fw;
+
+	if (uclass_get(UCLASS_MISC, &uc))
+		return;
+
+	uclass_foreach_dev(dev, uc) {
+		if (!device_is_compatible(dev, "qcom,geni-se-qup"))
+			continue;
+
+		fw = dev_get_priv(dev);
+		if (fw)
+			free(fw);
+		return;
+	}
+#endif
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret = 0;
@@ -162,7 +267,20 @@ void board_init_f(ulong dummy)
 		goto fail;
 	}
 
+	ret = shikra_prepare_qup_clocks();
+	if (ret) {
+		pr_debug("failed to prepare QUP clocks (%d)\n", ret);
+		goto fail;
+	}
+
+	ret = shikra_prepare_boot_mmc();
+	if (ret) {
+		pr_debug("failed to prepare boot MMC (%d)\n", ret);
+		goto fail;
+	}
+
 	event_notify_null(EVT_LAST_STAGE_INIT);
+	shikra_release_qupfw();
 
 	preloader_console_init();
 
-- 
2.34.1

