Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1DF606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oX6L04dh;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VW/yad9H;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gt4ByjsZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 977AA606DE;
	Thu, 29 Oct 2026 10:57:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zBWuElW7ZRLY; Thu, 29 Oct 2026 10:57:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 88083606C2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793271476;
	b=TV7/5XoxXq9NsGYUs/7sLZ3f43rwEvM9QtzvNoK5InTbJTBQ/jgPdS+CFDRCEE7hkwAd
	 /XbG4cuNszctcylCr6izTPIyghY0tEDej7t0jrSyF8PW3upT++sfpyi1WU2MipbOUvD/4
	 WBDgfTFh9pul6EHyPRv5SCavI/FNrrlm3GMEAQBPbK/6ZbZH29vS2WDBbts5160jFMGtA
	 /bxAZNtE1jT/EY0cyYjnCw3NsZMb2zDyYnPJA1o/0Y2fvU8HwSEf0eLPAwnBTC8TerklI
	 EPAybrgu3XtADVbgES96IsA6X1l3g0v3b3z9FpHgabgN53xKKZJCdbaBrOjHJH7bAOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793271476;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pOWtVtAwdBTgf98+J6P6XhEa3PDzGIcTXoILhGOs7j8=;
	b=Q1wQJxhnJK3mGmQOM0+EylLraukdeutcOCRHZfkuf/C9XuUyw6LkIaZF+B9LsLwiUm39
	 l0PCGsM7DqBh3JuJk5/8Y5CQ9Wwwh8RWWouH0oxRHrOScQ+B9Cz0W7eKJpr0Kzd+zCiRQ
	 B55/0brtQml7WivcjMmNONXPaX3q/O7HWj+xU64UmBARlHztIOlxKiSLHzXb0xjuPfp11
	 cZ2R16b3WGvnt3XwnLMrI7s4FiC94gZlaVCZQcWluM3w1ddBz5hgQGKkSWp0zKXKviW83
	 N2aqd5fm2vk0AreTkoxc0gqeav47rkNmbClrLEpIvVkJd8+M99Oz3OLoGQZSn4CQ2bg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793271476;
	bh=pOWtVtAwdBTgf98+J6P6XhEa3PDzGIcTXoILhGOs7j8=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oX6L04dhPfX2UuOLRqAQISRtqp6X29EhoZCNFcOuajwWsvVY2Jl0/bAszzEGrzZ7O
	 +74mo6HCLyRoRDGHXnY/QlobIEtITnFnxHuDba87ACyexJRzOEclIPXvT8M9+qoLAU
	 Ge4Gu0Y23nPVGGm8lQ6rszFdbMD+NCDy1gd1nC4o8LTkZIO1H9Kpx+jlmXx2a2wy/W
	 9x9yJ1on9Nhh9UDQy/hkQX3dHBfhYlyANi+gQvIwsUbaefMEwzULDEzdXPQepObQdE
	 1OdzcUkeLFnuJB+1BCxdHHYJzZMTzlp946zLjd04rMadSwwN07NLh3LwOfQcfi8AbG
	 0qiIPaq6LY51g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88083606C2;
	Thu, 29 Oct 2026 10:57:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F690334
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 90F1880F97
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P3_y2bNFMo7G for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:57:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D8A9F80F86
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793271473;
 b=LjUups5K77XN6NZs1I7QMAXaYLNiQ0AtxM7W79TQZmTXxgYLWHBxI/fWswmWTMEcFhBg
 EGK2uTKaA1Te4Fua68av5IiAVi9EBOqY1RZ9MCVHbTep/xuhIT213FcoiTT8LBb2jZhUq
 0gGCfWPuM5fgNpaDt5UbQR6DrqLcCMgDj0qeUJDuoSJe1NnyHm7kah0BfqjbMpgDj62fn
 T33rae0lHFc8MSk8vvLjv2zdpjrHNsPwu2gTbIXgXslHkvOOnXgBhQz6T/4p4p3khRkD2
 TUoodOn4jqbDXzJYnvEVg7NBRx6Q/ba8jxfNVPwIRAWhyCO4d2EVJglXt1KYqTeyxew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793271473;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=pOWtVtAwdBTgf98+J6P6XhEa3PDzGIcTXoILhGOs7j8=;
 b=awZecVxXL0IRjcZ+y3E5pFX3mr0pSBOQYPsb09xs0ylyr/3TAyro5MqyS1Hyv8zyJ8/Z
 ehEcw7wzRjbMKM0PxP0hu2o+XMEI92vO/ITsIXNKET14FB8lMDbK39Ji5AoJ5Kpp+Fy+v
 JPJ1g3v5jTBD2fJGudimqOZ4dWQE7QsqWOFe4W725bnMvPojiiadFnBmBI5Ottkxc+77Z
 e70wP86+YFISjIH9Ja2MEE2Sk/5eJV29hG6zNEMiM+yNbLTL3ahdlL2p93E+JDwXaPlbg
 LAv2ObwkgRA+F+cSxhADBs7ObxHGXkNGNJDNoDrW9tSDisgJt4eYJPF84+JBFnBKA/g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="VW/yad9H"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Gt4ByjsZ; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=VW/yad9H; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Gt4ByjsZ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D8A9F80F86
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:52 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8vsNu3279691
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=pOWtVtAwdBTgf98+J6P6XhEa3PDzGIcTXoI
 LhGOs7j8=; b=VW/yad9Hecj7g8zBkxwGCgkd3q4ZqffRaTZaK8pLGXYObYBfBm5
 MATKWU2KPoqLdHbtbp/OkkwsGgPxU79OANRhbUSQdLqNZo+qDGWaW1GZl4tAVyLW
 IWMsADBGTJEgzSqPqsdtE9Gj6qwv3fF/p2yCB3YGzKnTwkhIkBaZyl71TV3yVYKe
 hih31hrk8h6H6w0vidghBhX9JWbLdVqSvEWgiu3APy9thN8kfl4tu/q08usvdARg
 QxlGK1KQ0jQzRygoNu6QUk4FLOf/+2bZd7rh3Kj+2LzGAYHNih81y+qU0lHmAktS
 Av7sR8fN0a1yoDrcuy4Y+75zgwOoGnr9XbA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hks3nan7y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:51 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36a1e2485fdso4326816eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 03:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793271471; x=1793876271;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pOWtVtAwdBTgf98+J6P6XhEa3PDzGIcTXoILhGOs7j8=;
 b=Gt4ByjsZcQAvp2l6hkfAuIFc1udaZuRz/HgvE7ZSe+LdxzOSfOi9rTNTgtXPoJRI+3
 NXYi1OEuXK/8WhQlbwlEysPPg6IQkdMNa9iBAUWIbRqQ7GLqToBbCx/uiSSF+pDJphlj
 cWoaaJJgNbb9mZ+G38ByBhcSECWlj3eXXQeRnxSLNi5mXbNnfK0tZ3/97kMWevDxY0sE
 f5hGOL0FU3iH/zXpru+etgafBSsIlRcf0KNcuP3ee/xHKqAFbjgzvbpc1Fl/TAtYyOG+
 t5RDy6pDblxa7ghdbY9+LiSVU59seHBHuhsSE6qQuoKGwzPF5kVoFwgEAq+T5ebMYBq+
 2Crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793271471; x=1793876271;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pOWtVtAwdBTgf98+J6P6XhEa3PDzGIcTXoILhGOs7j8=;
 b=EeCej1ZxMIwZCI7/9ziMB4FegU3AmF8SHRc6VufPOcBMvHmY9Qow7GRauy4m4seDC7
 XvBZhhoXKf6Kj1LwR+QEiAiMPEbbAiY0+4/ppe1v5EXJ0TiDUEl03SpdE86b6fqgfJmI
 /ENbRA5hFreX4AKvFrpgP/3BqzpXf+da3SldTGzYcJ9zdL7DLA8jsbWF0E2KIbuRj99E
 prkq2WVBxXPif9w5Aiy+KboRd2jTzPnd2BW9LVlNGlTo1sA5vFW+xKzl5XMaZ8TxOX6l
 LyM+0h9Dasu7t4qhhSNH5VkxRTPZ75/o3QD3pSCVB6MARR9Y6vz3XdJQUdVgQl7e6CQ+
 buVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJZHV9UmNXWa218IW5lF8OhOfVqLzvSlAVLwFETfH6Q1M8+04WabK1UF+1Hkvkiy0Q+UZeqlI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLQWGijsL2hbwc3XR7CW+HnHQAyK2OdIksCFCjlDeWXrKcBc+YK
 K2s1AyLlPoXUT+rKyHaYFy3qRn9vxFlwlMHkywOjsac6aOT6mF0Dpby1wDFDOMe7jM+VOGwSg4l
 rbEEV3W8w0nsCt2dGgUswlwohTzTUitw6XAVyPb7gIHohEQ7Mdw6GOe7Mcx9XD/frFRSuOJU=
X-Gm-Gg: AYBFou3Dw2DowBX8Nv6GutQDHUpOyx9oxGg+qxT3JYurFq01x1WZMsvCE1Pk2UsZ33z
 FM7qbZiaeMddaWMg+efnug1lIkdyTTGXq/XfnXGOnIzQ/HHrmN4giRhGPR1W41LVM4fF1inXyZo
 3oQpKN4Y01Uoq1HwnRQdmaSYiKtUtu90qdY/Ib2FM+w9PjI0tRk3PpKJVkMauVI+O8zZhxTX4EB
 VMG2FnfG7uD+/92wO8H+xnHG8Vsc6CyMpjNCTg0gJ7ktNnhrGRWCuTseDGwZYee3D6k9Bm/vqpH
 ie1mmRrPfm2E4HQfA0tnuGYaELTbmR7PQHO67XM1NtLy67VCCoLz9eama+X1LoZqE/CeZaLvAMF
 1d/l8ANC5lpSu8j66zbRkZYRgsiiLRs4Z1VEgUSl0VW+/j2wLI6G4oZVBOZofxinAqko9k1l588
 x/KmoJ+vvnvYUomdupcr8pLg==
X-Received: by 2002:a05:701b:42c6:20b0:143:54c6:6a5 with SMTP id
 a92af1059eb24-1a6d00d2a21mr7076273c88.37.1793271471107; 
 Thu, 29 Oct 2026 03:57:51 -0700 (PDT)
X-Received: by 2002:a05:701b:42c6:20b0:143:54c6:6a5 with SMTP id
 a92af1059eb24-1a6d00d2a21mr7076236c88.37.1793271470429; 
 Thu, 29 Oct 2026 03:57:50 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75d4887easm14645551c88.9.2026.10.29.03.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 03:57:50 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v5 00/13] qcom: shikra: add eMMC SPL boot support
Date: Thu, 29 Oct 2026 03:57:33 -0700
Message-Id: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HkGqmsIPNVPRr8NVYeUIJXRJE1HjqSZW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX3/A8o+2nI/yy
 8wBZAhxUBdcYiNGEgBkhKBuMzVyv3GNfy/vy1BJgGHxwGga85sdbKbCATbulq8da+p97iTYXIaa
 whGSlzP5OJZTTBJvMek0eeDJ0kKhUdoXDg39zZydAyGr/lgjIylobcfY78Kkg3NxsxJs1HAjnYW
 Y+RfnPIWLGHVt2u0Vju/ijxamcMQg5KvdDLhKqFSoE0HB8GYImPIQo4S5cd0HHw3s3zmsYU3zRG
 A/OWMxAOn7ihl5NgojZFoeGtbHFSvRj9hSlZzotSwVwfOEWDSSkQ0G3YsbRRAsVkiF8ftaUBank
 VnRzgd+raxQDC294FnKEoXu6KQYWo2KCfqXg+PDMt6IvkIxFMx6J5Y/aux/Xn5WwSyNXflNQlsP
 zFvJnG3dFUMAAM9UVI1zsGhgwC8XSMWb2KV/nq58XD/rLqjzhWHDLFYXxbW+Iny72sUjxb5ovTg
 /oCU5kxMQTzthYHLGyQ==
X-Proofpoint-GUID: HkGqmsIPNVPRr8NVYeUIJXRJE1HjqSZW
X-Authority-Analysis: v=2.4 cv=XZEcX455 c=1 sm=1 tr=0 ts=6ae326af cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=gu6fZOg2AAAA:8 a=ATsbyuJYeBj__F-aJUoA:9
 a=scEy_gLbYbu1JhEsrz4S:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX5IU82G24Xpdy
 JheKH6tcvgnICNNbD6uXn2re90bxMI7YrSnkQjgN4iaxae78hVLrpASh/I1wDYeQCcOzBj/xHOU
 xmyT+ckaz3+u1dPA2s36W35CNT8aSKY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290042
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds U-Boot SPL support for the Qualcomm Shikra platform.

The SPL runs from BOOT_IMEM and performs the early initialization
needed to boot U-Boot from eMMC. It configures the required pinctrl
and clock state, loads QUP firmware from its GPT partition, invokes
QCLIB to initialize DDR, and loads the U-Boot FIT from the eMMC
boot partition.

Dependencies:
 
  This series is based on the following previously posted series:
 
  - Qualcomm IPQ5210 SoC bringup v10, Varadarajan Narayanan (15 patches):
https://lore.kernel.org/u-boot/20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com/
 
  - Initial Shikra SoC support v3, Aswin Murugan (13 patches):
https://marc.info/?l=u-boot&m=178668446732727&w=2
 
  - Enable HS200/HS400 eMMC modes on Qualcomm v2, Aswin Murugan (3 patches):
https://lore.kernel.org/u-boot/20260902170559.3225833-1-aswin.murugan@oss.qualcomm.com/
 
Changes in v5
- Added cleanup

Abhilash V (11):
  arm: qcom: add common QCLIB SPL extension helpers
  pinctrl: qcom: add Shikra SPL pinctrl option
  board: qualcomm: shikra: add SPL board support
  clk: qcom: add configurable FSM-voted PLL helper
  arm: dts: shikra: retain QUP SPL dependencies
  clk: qcom: configure Shikra GPLL6 for SDCC1
  clk: qcom: enable Shikra QUP wrapper clocks
  mmc: msm_sdhci: make tuning callbacks optional
  arm: qcom: enable MMU and cache setup for Shikra SPL
  board: qualcomm: shikra: prepare QUP firmware in SPL
  board: qualcomm: shikra: embed XBL-sec in SPL ELF

Aswin Murugan (2):
  arm: dts: shikra: retain SPL dependencies in IQS overlay
  clk: qcom: build only selected clock drivers in SPL

 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi       |  44 ++
 arch/arm/dts/shikra-iqs-evk-u-boot.dtsi       |  42 ++
 arch/arm/mach-snapdragon/Kconfig              |  10 +
 arch/arm/mach-snapdragon/board_spl.c          |  54 +-
 arch/arm/mach-snapdragon/include/mach/qclib.h |  16 +-
 arch/arm/mach-snapdragon/include/mach/spl.h   |   3 +
 arch/arm/mach-snapdragon/mem_map.c            |  22 +-
 arch/arm/mach-snapdragon/qclib.c              |  77 ++-
 arch/arm/mach-snapdragon/qcom-priv.h          |   4 +
 board/qualcomm/shikra/Makefile                |   3 +
 board/qualcomm/shikra/config.mk               |  24 +
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds |  40 ++
 board/qualcomm/shikra/spl-shikra.c            | 476 ++++++++++++++++++
 drivers/clk/qcom/Kconfig                      | 208 ++++++++
 drivers/clk/qcom/Makefile                     |  48 +-
 drivers/clk/qcom/clock-qcom.c                 |  48 ++
 drivers/clk/qcom/clock-qcom.h                 |  24 +
 drivers/clk/qcom/clock-shikra.c               |  73 ++-
 drivers/mmc/msm_sdhci.c                       |   4 +
 drivers/pinctrl/qcom/Kconfig                  |   8 +
 include/configs/shikra.h                      |  11 +
 21 files changed, 1187 insertions(+), 52 deletions(-)
 create mode 100644 board/qualcomm/shikra/Makefile
 create mode 100644 board/qualcomm/shikra/config.mk
 create mode 100644 board/qualcomm/shikra/shikra-spl-wrap-elf.lds
 create mode 100644 board/qualcomm/shikra/spl-shikra.c
 create mode 100644 include/configs/shikra.h

-- 
2.34.1

