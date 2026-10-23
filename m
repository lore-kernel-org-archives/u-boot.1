Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DEF606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p8S3q6EJ;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WanDBlJl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i2kK5Cc1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 311EB6065A;
	Fri, 23 Oct 2026 08:40:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LkIT6xEpci58; Fri, 23 Oct 2026 08:40:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1777860664
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792744835;
	b=jsn8WP8xbb9DJidG8D6ysCNqf9jZqKyq3j38h42yxHvnQ6Sxl/rsmmIqZaMD6jzZtBDr
	 Bawc+1CZqV4Sy00UA8T78i0wupHiP/hvwbwbN3fsypYq8lXRrOFt8hJnjwFeNih+H9S9W
	 OTgeQp2nqUmpt8HQl2dCsVTzey9JNM9LOyXjsQMzLeKawfdsLIvUFJT45v3LdgVKT8hVY
	 M4B8XoihAErU2fxPQwgfiQ9LsXs0SlvWs4fiL7lKfNfMGDwM3nzP2fDsWoHuSXvZhx4Vj
	 fZVQIqMVwsIUJA2XA2bGTN16zlk7BCX7o7CVDMMEuE347YhjXMRGkZNj2BvD0avvGxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792744835;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FDBV0glCZcwA9uW8pkahWrkPys1N3Fi4wyJ7zD8ifvI=;
	b=pRFKETnZzxOWQn05HS0WzUfqWzawnsoL5+jkM2yi947LfNyxn6GR6O+zLGGMYf+Y6QIT
	 fbnHgo4uo5vjMYoZpO2TQ2pAFh4RUkeCx9nw3kJkjMdpEj1Pb8akTioi/cY5OnOhqVN1L
	 bP/+7lvt7rRU6gDPtO0fGSbSDp61QrPvfFe/aNmwFqEg6o8+LKEpfOz3ZEbtydWAfk2xj
	 IAQn3AycABAx8peC//4cT+a/rqsruOgs/6d8jLJYjTETqzL+CtOhq9uWJLnSUPgkwJlHT
	 gzj8ED2DuNl12PKEiKJ9hIhwDkENlytcr72TilCbPH7CrJRLfosVLXRtkl5+ElwWmqw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WanDBlJl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i2kK5Cc1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792744835;
	bh=FDBV0glCZcwA9uW8pkahWrkPys1N3Fi4wyJ7zD8ifvI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p8S3q6EJALB+R3bEtqjJL4M59rOCv8yTlLCIo1LW19lQ09ghRtvzGnBXyQhFEEvYY
	 cgBc2lIEMxmcU2zBR+GLvsHEkKIjC4x1yqfczapPVHklwM1Xw1j3l/t8s/GcPsbehp
	 tqbfReJFkbGFeQd909tJ4SpWu1G2ctEwJuq8XNp3Sc4iYjtCkSDvgZbVzP9Nw9/Wu5
	 gSq762rF9BFhyYwy5nxCj38jZkQtpV0RYgXY5gwkI/vTTi1pejEtvFLaRMwwiWZDOh
	 pq+C8SkXCy/9y0GwXrIzCmCQ1sBH+o7TOslmPvPmxzB19lL7tciF2JIRigO2E6zSBt
	 m+SBmM1TKDfdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1777860664;
	Fri, 23 Oct 2026 08:40:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8EB5F235
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:40:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 804DE60668
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:40:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bcv9vmZuIJcU for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 08:40:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B472160660
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792744832;
 b=Ov3oxI8jEILHS3dL9jqTri1/TSAs1VPh6unEgx+UKKUTKf0LWGV+ykTD4qkJRO6w/YSz
 vhJNPSoMTIrjkdPQIjv6wuDFAoNajy6UpFx710ueRYh3crUPyae/SwPPkO7vabvzGatv+
 6Y1EjYU0A+IhixD8CYE7zTly7LHHQ54QiTOvSXpgaQJ0QyatCnNTmqNRNGEcaeRtkaRed
 KBcDaw9IiQeY9L8H+CVpJMk7O808Lom1yv1OPXSGz+GLBLzsVLgH3zkYrKJzKM++f/SXI
 ZYv3vMqPmQR1XyoMLAYGhygST3DG8k3TRLPEflGxrCE4T/EaY6ZqQ60UC9YpbCu1A+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792744832;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=FDBV0glCZcwA9uW8pkahWrkPys1N3Fi4wyJ7zD8ifvI=;
 b=owy6n3t9zJHotr7cdGdtcRjBC4qUxvsGxvUwIIWCocblyGz39jIwKolXm44h7KKSsZq9
 SpY24Y1a2X09ctzgMMMUloIrLgUKnoYviQ8jWA1ffA1lCipboOd8VcQs5T1D5KYykC6jn
 iAE9wm2/H2VZa6gDG1mq4S8UV7TlZWSAzP/UQdFsUaHfyepB092uhcamKThfOzjIPMlN6
 uZxpU+DIzvkYxJ00f7Ogwd7vEAL/BLj6pAX7SBvX+e9tfb3OpZRE4XuF7Ipusp1IYt56W
 Y7v0nfP+3s8Z8XOx55ziNxV5biOIxBlpnZ/bmqxmZS4C8Lkty53kooUJdPxRU72JbfA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=WanDBlJl; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=i2kK5Cc1; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=WanDBlJl; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=i2kK5Cc1
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B472160660
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:40:32 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FMxd2572492
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=FDBV0glCZcw
 A9uW8pkahWrkPys1N3Fi4wyJ7zD8ifvI=; b=WanDBlJl3WzA1LhORxGZMFacPwB
 oY8CrAeaH9iA4sBfemayHpxFyrQoX64JmfmIALcHCeKhoV4fdV6RdYvXIWZNy0vk
 3/OQp2+FdSxfjk8kkxq8NXo/yZgETDh0VlT9gd1JPhFCY1rQql765lGQ0rOjZeCc
 tP3W4mzh33mPFUTSTgRZPrno/UyCZsELoRMwhKUOp7PvZ3lzvEbXJwxRHtMMOzE1
 Sqz7SR9nDsBrXf/UAbTvepiadPf3DMrsoVFfRxhZi/DR8iX3XMyHwL3naLlqr8yN
 w3AJ4FJd+ZpXz41JqJqRgonp/0icgXYt9nbe36IBRBbchfiKD1sVuN7W5BQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnq0kaeb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:40:31 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-18eb2616974so2157179c88.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 01:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792744830; x=1793349630;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FDBV0glCZcwA9uW8pkahWrkPys1N3Fi4wyJ7zD8ifvI=;
 b=i2kK5Cc1ock6PELLv9Simqu4/Lif5Mv3FIh8VOOUZSeK9pFnYFBAI/BQbvuBT6RSqi
 czQA8flRy9xtGS5Lfn1o8kTMu5NuJqKMfrEk3XUIV/gJ0ACxT8crV06vwBKKqugCKyN8
 XZtdzvKE9BGM9Rf6xJGPN5jIYyZvBsPVbKbNkzKR0421DV46+0d/cAjDdhBz0l99+Jtu
 sDQtgkI1IdFgpF91+mS1bTSgI/VZUvWnMLolMUN2ZZ1k9xH8HoJdKP3dj3pkvh3itCpk
 lBMFDctXM0svVSws6MrrfNCOp6ltZE2YRDQpvdS5KtyFzmOjwNxtZ0w6Z8J15q55h9db
 pBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792744830; x=1793349630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FDBV0glCZcwA9uW8pkahWrkPys1N3Fi4wyJ7zD8ifvI=;
 b=0oVt8Q+RtpF8o9OoQ6mbaDyzq40BNi+tCcHjsEWid+sF0hUUJ0r676zjxPAaVHcCwA
 5mwIoOmQg3+ugeSDSGyJiRKpm85AKufC5ipaXyG5u8XEDb+ehwNepk8uCxqz4dCgZS1N
 Mn05I1uUrhMWdywgXvPBG/uTaBKLvaBbloLEpb81wIHVdrF4avrsOEf6lX9IwEhYDMFD
 4IZsJKqyROxM4ax/alybXGj1/X50gB3debqvRxhRV02/nlOr14IprOqTZgcWpfKaT0XF
 ENS+TO91aoFopIXekHg/84LUQeq2BBzMRywfKJIg0uDgfxsFqvlwwwmEuMUQv91pfBuL
 035Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwi5Pf7xx/+TeL5++iE6niSp+SnwHQHrY8NF4JBmNURqETzyHGNngl9T+Qu8baFoJC65KIi3yc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJVazqMC/yBha2gnaYUxkv1mivsvEW2/DCECDi4wi9uxNeot7dW
 PtT7QOdc8UKoliR+SBKxHBnUTcR23Ug52BnNBMllvh3+ltuzuvvXj5BodrvAXxcp/pWM9GwcQ9+
 lSSjNLOzYLda+wbUGVkPCqBuuAl8q8Mfg02hClW0E2so3+Rq+yWYBP/abajYFZ4Qq5G6oep0=
X-Gm-Gg: AYBFou1sf/oFkH1TcELAVc0fRwnUNq0S4s20NwqRUEUH8aqEQTbwA8CfrnnYM7ogreO
 7B29TY5rzRn+7sSU9LASSgxVZGfeLbUAOPxi7da1q8FqrXQpWgWS681DI6uI82o7bbcKu1QLXFz
 XZ4Fo49UXZX8aa7stRbSU83RB7hfAUCt4EKO5oavyHfBJyuUsEuY8ndc5VabIZ1XLStcXIDjrcu
 Cl/JLAl6FZGgr6HZNIr6YxHUV9AIOzukPMG+WRqJqPoEtM73K1iA7T83F0knNlMHCCfFiFn/SXh
 201MJbve/b4CaczXPX59sbMgY6DgBGLO+1IYtLcsZckXSl4HtMYco1cnUzFxJ3NgUU8Yv7f6yVi
 /PWR00F6SM4S4h1MwfSWThK3qk2txJ9fRHCKpl5F5iYf19xQ=
X-Received: by 2002:a05:7022:3c0a:b0:18d:ac5a:89ef with SMTP id
 a92af1059eb24-195a0379205mr2646349c88.31.1792744829739; 
 Fri, 23 Oct 2026 01:40:29 -0700 (PDT)
X-Received: by 2002:a05:7022:3c0a:b0:18d:ac5a:89ef with SMTP id
 a92af1059eb24-195a0379205mr2646326c88.31.1792744829198; 
 Fri, 23 Oct 2026 01:40:29 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-195ecee637csm4748516c88.21.2026.10.23.01.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 01:40:26 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, kr.sowmiya@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 2/2] mach-snapdragon: Kconfig: add CDT configs
Date: Fri, 23 Oct 2026 01:40:19 -0700
Message-Id: <20261023084019.3722376-3-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023084019.3722376-1-abhilash.v@oss.qualcomm.com>
References: <20261023084019.3722376-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: texYNjtlaoudufUVrEm7mQy5WjPhjZwT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNCBTYWx0ZWRfX50ZCjZnsT9JB
 GXkUndUQbV2kOxFoq5hjV3jAabv+8V/GxXJoOiks+6YosqIvHrlyvpkrk5F2eLNLSc2cGWzV0MF
 UbN3qEUwaEMDQSk6JmYNbpv9ls0uRgCnrpypofUG3vKiIGwumBmv3+I7oGmvVWzLFVflyOYYuca
 bXo9wH1U4OEtd06u5mZfTcK/+caKfx5cGfVo8iAko1JPrS0FA4HeZC/seVBNd1ZGhh4Kl+JgxMp
 1DxjxUQHBbYAiuVs38u8uQGI+NArCa0JvW+7dScdft2KRhK0QVn7/6WS0Zc3vbPIz8X/z1u+l6k
 Jd0p6V0ujSWPZlY5+WMG9v5mjm8+lgWWg7s0xSZpGb32iy4duI5Gtjwlxzlq2K6KPtO47JDtaFg
 qJOIZJ6YmY7lPmpq3qdG3to0+s23A4M5rvCsXZjgXsGXSQ3qgJjRVXmDwxIzWN62TvUboNT3x8C
 Y2QaCBfDo81scFmezhQ==
X-Proofpoint-GUID: texYNjtlaoudufUVrEm7mQy5WjPhjZwT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNCBTYWx0ZWRfXzGXGL+HlPaiL
 83Y0ZHutuzk8KYzNKcogMhZXeYuH+dFdTpoYomJA7kdqEKke4zPlePdxy2M8ZLV4ehT+JkHrCi9
 XvyVs7uCvZqBbJDYoLH4qqhISigYe3Q=
X-Authority-Analysis: v=2.4 cv=UaHE26SN c=1 sm=1 tr=0 ts=6adb1d7f cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=K1wP0ue3e2HrOjFL06EA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230034
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>

Added CDT related config definition as part of feature enablement.

Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 9e23d6d8948..8ad9feb50a7 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -76,6 +76,53 @@ config QCOM_HWDETECT
 	  Hardware parameter detection from SMEM and TCSR for
 	  DTB selection and other platform subsystems.
 
+config QCOM_SPL_CDT_SUPPORTED
+	bool "Enable CDT support in SPL"
+	depends on SPL
+	help
+	  Enable support for reading the CDT off the boot medium during
+	  SPL and staging it in IMEM, so that QCLIB can pick it up via
+	  the interface table.
+
+if QCOM_SPL_CDT_SUPPORTED
+
+config QCOM_SPL_CDT_PARTITION_NAME
+	string "CDT GPT partition name"
+	default "cdt"
+	help
+	  Name of the GPT partition on the boot medium containing the CDT
+	  (Config/Chip Data Table) data.
+
+config QCOM_SPL_CDT_PARTITION_GUID
+	string "CDT GPT partition type GUID"
+	help
+	  GPT partition type GUID identifying the CDT (Config/Chip Data
+	  Table) partition on the boot medium.
+
+config QCOM_SPL_CDT_MMC_PARTITION_NUM
+	int "eMMC hardware partition containing the CDT partition"
+	default 0
+	help
+	  eMMC hardware partition number (0 = default user data area) on
+	  which the CDT GPT partition is located. Ignored for non-MMC boot
+	  media.
+
+config QCOM_SPL_BOOTIMEM_CDT_BASE
+	hex "IMEM address to stage the CDT contents at"
+	help
+	  Address within BOOTIMEM where the CDT contents read from the boot
+	  medium are staged, to be consumed by QCLIB via the interface
+	  table.
+
+config QCOM_SPL_BOOTIMEM_CDT_SIZE
+	hex "Maximum number of bytes to stage for the CDT"
+	default 0x200
+	help
+	  Maximum number of bytes read from the CDT partition and staged at
+	  CONFIG_QCOM_SPL_BOOTIMEM_CDT_BASE.
+
+endif # QCOM_SPL_CDT_SUPPORTED
+
 config QCOM_TMEL_ELF
 	string "TME Elf to concatenate with U-Boot SPL MBN image"
 	depends on SPL && QCOM_GENERATE_MBN
-- 
2.34.1

