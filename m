Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2A0606A31F
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MUSUuO1y;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZHD5xzZY;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZQ2bf8lR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 805A08101A;
	Sun, 15 Nov 2026 11:51:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zOZISlF6Ifd0; Sun, 15 Nov 2026 11:51:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BFCE68105B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794743493;
	b=sCPenShEkiuiaxdgMTJ6nZHpaYuapmSjxLUGDLOoU8m1NOuWSOhoNdujbAkB53oIpvqm
	 2H22ml4Zx3qTOhriObaytsrFjsLMGRXj/dA0Qe13UUvEbKzB6ERDIQuxGXrxz0U5lVfXh
	 Lws6yKyzBloQcYBPdcYDVlMh8tXRBY7NB0VXgenWtrFn2ZHBTjlzoUAqY8xux8P/wEoya
	 cfycAY26KJ/qg59SG94U8HBNDdYkG72J73v63PT95PsXBENzCm4xSmmQvGU9/6s+1dMLR
	 Pcp9dQDrzgX/uLP6fXS9CUlL8rhysRaArqVqlvUXPjIAu286EqdsZvjsYqyVlSOD0AA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794743493;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dATKNKd/D/RkVi/39MOAVTHAU7vkvuJgGU+cGQ1Tvz4=;
	b=Npz/1Tx/wf7Ca8VPhwX1scT9MtuEo8IKB5Ui5bQWsBTVn0zWuI3Wjjaj6WCzwCBN6ybA
	 SiK75vAHXW7WbR7irwESR4v+tBcLDmVMabHD/thBWWSJ3Etue7hoIGmYWE5e4Bw8PFkBR
	 rwQP1qYyRDM1JmGveErPVTGpML7xHLQR1lqljYMrkJm6Cry630m3hbPoFC8CkBvQVMItA
	 odIPRB6YONGWzNXwHXwONqv3qAu7PHQPuZHHf/0VXuEIPtQYwQ+twKQjFscIvfnl+I+KM
	 zcfgHjsqchLDqNn3ZcPxnyKemGfqJpnUGPI8GrBx455pNUJWJKiSI7KtVBlKhC1rfsQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZHD5xzZY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZQ2bf8lR;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794743493;
	bh=dATKNKd/D/RkVi/39MOAVTHAU7vkvuJgGU+cGQ1Tvz4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MUSUuO1ySk6KGXItyMWZidg+WQFtglf6HtTDtitQe2OGiazZ38zYP5lytcUf1NNLO
	 85+/frg7Nc9oUKCKaC1Nw14H+P6UdoCTClh6rGdC+s34NbRvCAfkBCkt+YRLMLFZ6A
	 UCYXuJvmKCdhx37/CtufSEEMqWE9ua3oD09c8wFL9h75cCXYKgtjg0OraWwECVBtvw
	 QKXKnUY5MWNzLgG+bb8m1YEESTd3wc3yQxzoUCH8/wNbfPgJTQ975PjSAe7beKXvsj
	 Kc2LAr22bkKlrxmUTdLWzU0STq9SdMB/pHA9lrv432ulRAoMcQfvKPE9ZGrmt07Vkw
	 LJ2Vn/Iy9OJEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFCE68105B;
	Sun, 15 Nov 2026 11:51:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 551262FE
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3ACF88105B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jN42zp6_xsXI for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 11:51:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C96A28101A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ZHD5xzZY; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZQ2bf8lR
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C96A28101A
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:29 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AFBmBZm048041
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=dATKNKd/D/RkVi/39MOAVT
 HAU7vkvuJgGU+cGQ1Tvz4=; b=ZHD5xzZYl5cGE4SbyBk4ywCecfzjjK34olgZ+I
 9/hy3Yvia3X43Z+ubOIUHRK+4UGSTwDvmbPy0TYZehEKc+TP21UOJMcALJTmsSOh
 cXm0dxUv3c5b7YIRijJlQjBGJjZh600pgulf0Bzeme5Nq9KYV3yzBZFQQP+1ZDiJ
 hVXkyPtH0kLiJjFQupS6vo+vAOG1jWMM5C5bPZry0RYQ6q1jtQcSGP2ks19bAj1D
 JV5xfH8+Rs2KZJbu1cEdVe0L8HpnTqhi+JWHhga8vwzFMOJhc5Dzxu9RVJKHRfKA
 1yk0gt8Sm1gsfapveZFhCnBCz01p+JWtnae+R7b777w8kV2Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhm8tsp5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f6f4fe531so461282085a.0
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794743488; x=1795348288;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dATKNKd/D/RkVi/39MOAVTHAU7vkvuJgGU+cGQ1Tvz4=;
 b=ZQ2bf8lRVlHH2aw3YfJSmyxU1cMBEZWuFGoU2EpifaFEZLpqeUS/jHEi/ChR0FfpcY
 E2wOX3zH4Y2bQXUsZ51U32rJ6H11yOHPccdVTj7k4YT3zl9PbqNqA9mM/KNSQ6GF6w+m
 VpMUUhYtUYUGeJUNeewaXjAqGtJ6atHG8nqVeyXdMKif0p29qffgiIn+XmlHowUxq8Cx
 VQuYGPmi7CQ+zmWcTbfkyumokisDvvD6BW/vyweSfz+1qEHqPbMER6UYm6xym1n8uRHh
 OdDCfeasU+GcefGzmiEfpY+wiGjv4qXjwNq3wN+G9mbrsqIRnpxuygJQj95YW3BjAchv
 IRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794743488; x=1795348288;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dATKNKd/D/RkVi/39MOAVTHAU7vkvuJgGU+cGQ1Tvz4=;
 b=JAfKyRFodlL3ljX0/BEWdOTTYhM3ZctcOC/5KBN0bg/6zCL1RD/jGbgmUYRdN520Nn
 9wUHzDbBw63PNMXsCNz3am2fisBE/CLiwV9NmldRejvsI2MQia7UwmCB8IQObM05tV92
 M6VSnjslhW0rhp1+D/ZaD690HWPfTDMrVUGSv7yOGco5VL9UIlKFwNXbt0DNRoEhhYa1
 bm3uCIbXlsW+4kRBpP+zTibLeATuegoTd7k9eq/XLMNKc3JhEvclRAEObaTcwBjMMPrp
 s7vzr4UoshE0aE3Ij+nJoyGqHpirytlheRLCX9z/IMOSF5ga+yCPUjFGEptlmHUldj5r
 1LJQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHL1LOWnzUzVsomQVlAPXK+vpnU2hXxuKHebKBB+6yjaqLfERSTfQN9JjX+bWRAP0fv2REbMXk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9pihucV9JaTSP1xbvquO6thrqo1NYp4wkaB8t7w0UOUvqxUjM0
 u5yiXzHlR7aDu6swUvnb0xt3lN19FITmrp/7WdKhEqx48NK6uewwwhYRUMzW8owSdWEi3ht1iDK
 nxGl3ue94RhJhjhdSuaL44LXUeJIi/mAT4sbHkRG2IzIsu6+ODAASu/OKZROzg5liVPXqSu4=
X-Gm-Gg: AYBFou0EJYO7a0Hc9kQ6ID0AYEm1hGuCVJpxqHlp0u9cJxbxlkE3UQ15Va+jVN52S70
 /6D2GJymuON+Pb6o4qj4FfFs+UMvl4qJbJ8KzI4YDGIKR1uSF8xNpSD15tnsTzKZYCBblBZLiDC
 1YOtR6a/C01zkV4QhP3EOCGXesCXD8ics9PvORM6mJPYI3CTW3fLqZhDZYKLr8i5KPC40u0p1hv
 q3i26C8U2zpQmC/C6M7Ql/IEWeaYRVxXjgyqjrgvr/JK6YfFRoJv3+JHpS1kLTVyFsdnFT0qmb+
 +j5KOeMSzYW30500UvW4GE1bb4O4AkjffZYLAMZRxy1rz+6OFwaE0nTSctJu/qljmZY6DWf4qjd
 19wBRj18hGmjHy7/qHa3++J7jAld1mqtMQTC7McG5eeF1CuiG7XaWyLscKrs0Bj9fXfIiW/0k69
 6OHKvwEuZagXYX
X-Received: by 2002:a05:620a:a81b:b0:949:5db7:b327 with SMTP id
 af79cd13be357-9495db7d7cfmr663988285a.68.1794743488174; 
 Sun, 15 Nov 2026 03:51:28 -0800 (PST)
X-Received: by 2002:a05:620a:a81b:b0:949:5db7:b327 with SMTP id
 af79cd13be357-9495db7d7cfmr663986485a.68.1794743487764; 
 Sun, 15 Nov 2026 03:51:27 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b3dbaesm299969066b.32.2026.11.15.03.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 03:51:26 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH 0/4] qcom: RPM power domains over GLINK
Date: Sun, 15 Nov 2026 12:51:17 +0100
Message-Id: <20261115-qcom-rpm-glink-v1-0-6255beacc93b@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0NT3cLk/FzdooJc3fSczLxsXVNDE4Mky0TLRIPEFCWgpoKi1LTMCrC
 B0bG1tQD+W7ATYAAAAA==
X-Change-ID: 20261115-qcom-rpm-glink-5140b9a9a0ad
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=ItKL47/g c=1 sm=1 tr=0 ts=6af99cc0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=a_3HhH1KA4dAFxsrUfAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0NiBTYWx0ZWRfX4fG+Q9F1QEGx
 UtkR7VNWfKGSrqUP7BqVA5oPIqLtP9/Uz7fgfQM/UiJNn/PU72TSyUJj6hgRLGjdBnHa91EP9yp
 37a7r3et0PqGyeKBiszpJJufM2VNqF8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0NiBTYWx0ZWRfX3gM2zHxVcQUx
 GR4U9+yA414cscFWvKPcRZYbua7nY34Gx1vTtZVv8T7eZmhFN1J0fjCM1KgOX9XPdQIl9yJkV8h
 6vKGqCLAWEVhv+VYqs4dQSp8tw+VokITS//p9wz8tUEoQ7RX4itr6euS5aEDUaQRbzfjM5kwVL8
 TL9k8JrHK/LEd5pVSoPqhigwQ83ambLwrhjAjTkzEMAlFy0HB1WSS0X1SHLrTF7+8dVoDrJGedw
 aLVF4qCwV7TTEfiy1OBloqzP/dciM2Ve2TJ0masLucn0p778OfYIjjnXpYeFMKPyOHEnGNmuSC8
 NxLV8dEX53KizyLltpb+uPQNaZMi/enZS//+i7qkD7/YiLO1FBqZIQ52kgq1tPFwBGhQ4IVIA13
 6CjlP8AXoQ4t0vIRI+ql1KQ51Pw9V93qayrM5ScMNBF5zUVldAVhDq7AGF2yjzBa2zoQonYqx3D
 Vr2qKlaMjF8kqy0u5Zg==
X-Proofpoint-ORIG-GUID: kRBtVodv0ipTZxLg7EbB1qKSjsxrG7po
X-Proofpoint-GUID: kRBtVodv0ipTZxLg7EbB1qKSjsxrG7po
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611150046
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RPM-based Qualcomm SoCs (QCM2290, SM6115, SM6125, SDM630, MSM8998)
vote for their rails through the RPM, which U-Boot only stubs today.
On QCM2290 the eMMC therefore probes with "power-domain driver not
found".

This series adds the APCS IPC mailbox, RPM requests over the GLINK RPM
transport and the rpmpd power domain driver, and enables them in
qcom_defconfig. The link is brought up only when a consumer needs it
and is handed back to the RPM before the OS boots.

Testing, on the Arduino UNO Q (QRB2210) with Linux next-20261112:
- the RPM acknowledges the requests and the eMMC no longer reports
  "power-domain driver not found";
- Linux then binds rpm_requests, rpmpd and the RPM regulators, 10/10
  power-cycle boots without "Invalid open ack packet";
- with the link forced unusable at probe, the eMMC probes with the old
  warning and Linux boots as before.

Not tested: the other glink-rpm SoCs (SM6115, SM6125, SDM630, MSM8998),
which also use the qcom,msm8994-apcs-kpss-global mailbox fallback, and
Shikra. A test on an RB2 (SM6115) or another glink-rpm board, to
confirm nothing changes there, would be welcome.

---
---
Igor Opaniuk (4):
      mailbox: add the Qualcomm APCS IPC driver
      soc: qcom: add RPM requests over the GLINK RPM transport
      power: domain: add the Qualcomm RPM power domain driver
      configs: qcom_defconfig: enable the RPM drivers

 configs/qcom_defconfig                  |   3 +
 drivers/clk/clk-stub.c                  |   2 +
 drivers/mailbox/Kconfig                 |   8 +
 drivers/mailbox/Makefile                |   1 +
 drivers/mailbox/qcom-apcs-ipc-mailbox.c |  68 +++
 drivers/power/domain/Kconfig            |   7 +
 drivers/power/domain/Makefile           |   1 +
 drivers/power/domain/qcom-rpmpd.c       | 169 +++++++
 drivers/soc/qcom/Kconfig                |  11 +
 drivers/soc/qcom/Makefile               |   1 +
 drivers/soc/qcom/smd-rpm.c              | 772 ++++++++++++++++++++++++++++++++
 include/soc/qcom/smd-rpm.h              |  41 ++
 12 files changed, 1084 insertions(+)
---
base-commit: 36d2b7b46c77b44021f0a6f36684a123e5560492
change-id: 20261115-qcom-rpm-glink-5140b9a9a0ad

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

