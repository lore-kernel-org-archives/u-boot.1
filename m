Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F8E606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 05:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CxeEOcJK;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X52+q10S;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IP4sztJ1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F83060787;
	Thu, 22 Oct 2026 05:58:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UQaN3vPUrcFP; Thu, 22 Oct 2026 05:58:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8AC0E607C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792648708;
	b=hBg9+GkZk0h7VEYiTZe4kkCqZEiJfMhotiE8mlg5wVISmZW4DWnlB1SKNJWBBIgaz2gI
	 Q3KPJw9Nm+qbuosJ7fyDhlemW2OJp6zsfOZ0mzv+4Y48NqJt0qX63zy8eHMq2dGRdGk1c
	 UmEZ9dL1M6+9dUKdiWLa7Nrh/QqJn/i4ZmfS0GtUvzuxLeRXUV1ZBK53j+CFxuGm57ZBI
	 M8ovKXueCBbQf4vT6SNpUUP94janHG2mt2QIzAAhJnW+LUBEu8xT7KR8Zfjou7aQ4CLxO
	 LI0AvS6rWBv2xGojIKt0ghLUyXgJMrh3gWOkQmMBdCWMdZOhUfqURyGRmXl5aE2QJUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792648708;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=h13hqUmUCNOY1uFxLdq+qTxQsEnZWBqZMcOjEFG8AZ8=;
	b=mw0q6psXukmd4SoggqDBjpThl0P0JAEzajzKe5lbFWMUjnuxJeojFnIdodbYOfB8LgbD
	 9QT41akoHhFyFEPpPRmmnSXl20JvznBA6/2DHyFwqTDIJAdPCM69aiCHsGMKFzK5mXezy
	 7Wi6KHKofQSWZo3xnECmVjGUbebZsNWgkiPmdvFVWU1YcpfRINE2RVLBDsRSHOzcqDh+j
	 MUeCGLaHae5E5H5pqBwyFkT/UY51Ipmyt0DBVvzPcEFEUy/keDYFE1mfeH8JhEL8rmVpq
	 XUUKAyNp3C1jKZMxPIcYPTFScnmYtIVoarmfz3jroFGxhtJGP3pQLrRT0ZY4tMezkdw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792648708;
	bh=h13hqUmUCNOY1uFxLdq+qTxQsEnZWBqZMcOjEFG8AZ8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CxeEOcJKVJ0SOChAyRFnGXGXitYUwBumNxxTQFA8Jsx2FmgKclE+MWofsmuE5A1Ax
	 49rMfHuVppF98ACqSW+YLEaxoLrWaCMszJfWQykjXYBD12a0uc3lSMpLstyjLcAR+9
	 /8+KPIxWKfTgfQRdhB3SxyMkZLjkx6F/kk/2SL/FHdMZj4ZzfxDMffLuvXh/G79P42
	 oIeKDpqlQuX4ITntyiCgnEDewnn4vtztseT0ekTPHzpWirhwoEAtbKuVk75UoZ6mBx
	 fUC1DIHoTeV6CX7oPGc2nrcW3d/bupSsKHnc8sIsvFbnol0rI1mIrHjo3bRQDCEMJO
	 XRknBSRkUkhzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AC0E607C4;
	Thu, 22 Oct 2026 05:58:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4523995C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 05:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36B8440075
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 05:58:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4OtoCtqQ8fZi for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 05:58:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9080340042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792648705;
 b=IRXegE+j0DX+Oni/+p9n1QduxjR+ITz7xjYyroU3xMkUv+9VF2tQ9gcEKTuWUkVtIZTM
 LKYbFr8WhWoz03RsiZVfa6DsIuWJnborsUgIZEq8QVqsyHED4EOuq4N2fFDqLr5YpoTi+
 awDrtPfn5op/1yDSsRqk3V3xppHJyPs0LYc86zrFBuIABRMKDmZ472Q4Rw4L4egJnrm1B
 /Zy1WOxKmBpizMMUt6Is2dOAfxr0Q9ER3QOn7JV80UKugJf+prmOCGga/2j8Dj2+ovwAR
 YMVdMSdJrknV0ST+dfeH7gAPbA2uNu5MohC+6aCohbwXcmMoS7Cf26OkNmtJ+E+morw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792648705;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=h13hqUmUCNOY1uFxLdq+qTxQsEnZWBqZMcOjEFG8AZ8=;
 b=slLQR2CQwlD/Up3yCsfKOpMKC9freLf0CKN0oNNuHCgwYaUfRJE3IWof3AhNbHjMe96x
 +5cpL3U5tn7tS6a7du4slviVQvUsRPPWh+i1dNY3zqji9aJsvYkLHmmJdtLVwN13jnT05
 SjRm7qLaHY3N4ODJbmLEyrBch0dkA94tPu1xguiK+t6q8qL9PrDWh3kSy2GDU9YXwaB/9
 L4LRSIoug4v+8sV6WC6Sv0cBNIS0o3kFG/ik5JyJ8w+2B041Xecj+moHOotI80VNcFdbO
 nVxD9KpqP8RWhDRXSpJrrrWyh/EGDHc7Em5qDQkRuFOI78Lxeco+7vu4KhRrXtk/XDw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=X52+q10S; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IP4sztJ1; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=X52+q10S; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IP4sztJ1
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9080340042
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 05:58:24 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M3jHUd2658723
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 05:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=h13hqUmUCNOY1uFxLdq+qT
 xQsEnZWBqZMcOjEFG8AZ8=; b=X52+q10SEd5pzkWdd/GgB7e0d4eINUTbR6gSz8
 6roCpPeEQ4tj88qLYmQS/S/IppMa+g2EWdaUoLxVHcPkhdoXaOJCJJ8tBAb6i6yN
 pkbb9oYw7JYcQhkRxsN/ziJli8/vEA0rzrHHX+8T6Lv8cHRQkOyvh7B3grHI+VKz
 7fwoiVZ+b5j2icQgMo087EngHBnAAgyOye8tmJOiYHWibE/9fm/S6RDuhsWbxdmB
 yu85/Vqfg+ysn7QIYkH+N8BhvLFDSvzFc+ZEjoax5tDh/1JQXQOgD62OBx/kvQ//
 GEmz95H9MXLgfnLtWf8ug6sHhVJs1P+iqQP/coVSQHZ61u9A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93a0wjg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 05:58:24 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3510d0baf63so3530564eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792648704; x=1793253504;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h13hqUmUCNOY1uFxLdq+qTxQsEnZWBqZMcOjEFG8AZ8=;
 b=IP4sztJ1LeBtTVnTP2Uu0WDwQds4s8tAn4rdboVigclT+I9r7KMnQljmLpwyuYMGSx
 DKC/bTOoWXojvL0QVUNo7I7KXBHMOzWxZzwC2i1wrbMCeEecC6vDRn4AwsnDuRFw0/ix
 lXlUqA+hEKItIWfTb3IqNICibUE01wkXwrmncyUa4ZyLFVvtls35jJ+ze6qS7Yy/wmQF
 eQQEsrSZexcTtosX15Tqi4twn+4BfP55GxPOD61gZvUU1ErFSGWaNKDUISjIB5R1fIPp
 844zUh+XLT35VukyPIcDTESmrc/lZdGtLrOz3LC3NvAfY8Kl95tuxN93QrFgIfkHOWfp
 uaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792648704; x=1793253504;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=h13hqUmUCNOY1uFxLdq+qTxQsEnZWBqZMcOjEFG8AZ8=;
 b=NctC8ArKUU3huIjbCUwMczirIJ7Wgb4nuL4b0qvsOcnZ8vRQzvagYu3Vwx75+xk7PL
 p3NkmjUEcNl4IgawhjlJpPlTKuKoihZmaMAn5eHK8H+qgRSOgpu6ELeZH+0zJRPwedTp
 TRD+MHdelueUExNTY+fXcdqcEf9o1zF4u+0tIN5Bx2QzFlfj+9BwAKX+Ou+b0m70e2sF
 FaPtsMeJJfemuM+Ii2NGy1c50bJe0f3O3WfJ48cptRw4epynk5pxpI1LpTfj2HtFe3Hu
 qETXnjXM52QiDcns3m6HvUXTU6XHILblWceVZGm6APJck5K6YO7hU8LmlGSWi/Vk1Spp
 xMmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAD8DEno4NL1n0oRVhFqNmQVic0EhNVJTmyVcLGmH/uec6fAmmSx7pqNWSUhbD0F0B6KdoYOI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKan0NbMyEK5tq0ktQjSIQ7ubY6D8kyRM/6MQOnlBh+N9SVPBPM
 v/n10BeqpzYqJm4Hm9aR4c3jRCvG1PVsXGMt/2IJkYlFCShz1FTf9MA45FIM5NCXjC33RzDYj61
 jbK/59FRU+Eg3ldMNbuqHxoWKykH3f3CWw+a42+jA9QvOau/GDdqGwDhglBjCY7n/Z3lWcgI=
X-Gm-Gg: AYBFou3dQiOE+GT1oTfZm0YyS5tOFAFq9SLSCZZAIDgdXEG7a3gyvW6Frev1Z40tbdM
 GU4tWxxSuANfjBzGKWl+i3k07WhtHoanNqPb/uF/6vGJQSrjTBTyM51IqcAI28beHUA5VzsKpBr
 Y52j51QBcUWwAs+6yfVusPdK8/ha3mF2iqcCa63fvAuW9f1SkSl9zq0Dujv7YsEizVzchmFLQTa
 c7PbeJI1iDnkzu2Wrw53sOj+68muNaV/uzvksMj9eAjFfRKYkv6uVjH+QLrNbXGXx1A20R1xd8F
 oKOsbVtZM20wGjDra+YT6Hk0/aeZDINfJwMig2WdwJnKY/hB4Q1HpeHTFLTOZh/YvZeweMCzB91
 BfeZHBaAbXvAuuxkFcCP1W8uy+/wdRpoZ+uIS4gy3/veZc/m7YVi9IpE6gN2bTyYQYznSkOMJYU
 lyVtTEeYVREeFhCoXLtgflXD1UcrzKTHOyDVxSvw==
X-Received: by 2002:a05:7022:3b86:b0:190:b2a0:7250 with SMTP id
 a92af1059eb24-190b2a07272mr5650154c88.10.1792648703527; 
 Wed, 21 Oct 2026 22:58:23 -0700 (PDT)
X-Received: by 2002:a05:7022:3b86:b0:190:b2a0:7250 with SMTP id
 a92af1059eb24-190b2a07272mr5650120c88.10.1792648702878; 
 Wed, 21 Oct 2026 22:58:22 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903bb7f098sm17745984c88.12.2026.10.21.22.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 22:58:22 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 11:28:16 +0530
Subject: [PATCH] configs: qcom_lemans_snagboot: enable SPI-NOR support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-b4-lemans-snagboot-spi-nor-v1-1-c599656a6e4c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPml2WoC/5WQy2rDMBBFf8Vo3Ql62HqYUvofJQtJHqdq40cs2
 y2E/HslpzSbLFIQgjsM5965ZxJxChhJXZzJhGuIYeiTYE8F8e+2PyCEJmnCKZeMsgpcCUfsbB8
 h9vbghmGGOAbohwmU4Y0t0RjqOUmAccI2fG/wt/1Vx8V9oJ8z8XdjwtOSXOfrGukwRru51sXz1
 ZSzm9VqgALTHgWWgglOX4cYd6fFHv3Qdbv0vWTuHQqVkO/Dr7/4Y8ihU0JYGTBoJXOCe2aVcQ9
 TmcyFRKuVqkY4LaPY2vDHT1hFgipntFSNa2Xl/wO9ZdyabeYIK888Kqiy1mnqq8dP1xtolfkx4
 Fa30tMKndP3Gc5GhDwJc1202BheldJIasn+cvkBzK3IjTMCAAA=
X-Change-ID: 20261015-b4-lemans-snagboot-spi-nor-792da4e990c2
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792648698; l=3987;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=cgTvi9d7g36nhDlDuHA3RVHynZFv7e74o00GOBJCqAU=;
 b=RIzop1j/3AsoJo38pr23+KHUQ4HDYX9LXRQRw0uinp6v16W1e28sMwO+xIFzi42AH7eEpxbbn
 uZ+gdnux0vRDuGVK4C1A5gXIvAxMN7FeOp7DmeHm7fejxFXAHjVsjzY
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAyMyBTYWx0ZWRfXzfSfYXw6PaUf
 zfhigB/FJN6g6AFUithaLHncl8pwdcFsLauzcsDB4W1vvTbJbgMvW94JUDvzuor3GviyXqG1tpV
 YPuaLJ3HEbbpP5kQ+X8IJCU2qPWTe8Mtq1QVpcneb/ITLpWrEfxpBL0ta57NUgbOk0MNeIS/NKY
 QSFgdcRaab1EMb/aKVFv9x3mBB8i8iySnvsHGtT93esk7XfHuNFCFwpggXk0bHNA1IOgGhJY9af
 EA6rd4cK9GpCm7U+SdrrqNqRBYL8SqquKq4WsBr36kodj9vSG6w+1el6jRo83c866l4UxnfLUDb
 OCMX4krUWFqf2ZO3JN0x1p8iSVpvRiBJ8leMi8OlVHLJP7mA730LcbMnfZVML0XsaMCMnUS5JY1
 v2D3vhg8ogdxPFlvwlIVMMFyjhGuwzf+Ph2XgejvB2XUNnRmI/xggOZ2oeftKlGBALDt2D3vpoz
 oUu+jjM7bDAKJsG8Jrw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAyMyBTYWx0ZWRfX/ESBB10QK1i5
 rCBVKYJL5Liy45sy+MAmLaakiefLevfK1waINm4W7ShWo8pvGVpvKfhVrB3jKPF0rwQejBGbIWj
 F+QJBsA97NxO0ml+YwQCDufmMw0rapM=
X-Proofpoint-GUID: OETcG6a0yxMO3tIaO6Yxj6r_0lMJrZeX
X-Authority-Analysis: v=2.4 cv=NaFzRGD4 c=1 sm=1 tr=0 ts=6ad9a600 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SmLCJSUZm8TwtfxFJFcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: OETcG6a0yxMO3tIaO6Yxj6r_0lMJrZeX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220023
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable SPI-NOR support in Snagboot mode by selecting the configs required
for the SPI, SPI-NOR and MTD frameworks and the GENI SPI controller, and
CONFIG_QCOM_SNAGBOOT_SPI_NOR_FIXUP to enable the spi0 node at runtime.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
Depends on:
- Snagboot mode series (qcom_lemans_snagboot_defconfig, CONFIG_QCOM_SNAGBOOT_MODE):
  https://lore.kernel.org/u-boot/20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com/
- arm: mach-snapdragon: enable SPI-NOR in Snagboot mode (CONFIG_QCOM_SNAGBOOT_SPI_NOR_FIXUP):
  https://lore.kernel.org/u-boot/20261006-review-lemans-spinor-fix-v1-1-f61b32c1a79b@oss.qualcomm.com/
- clk: qcom: sa8775p: Add QUPv3 wrapper 3 SPI clock support:
  https://lore.kernel.org/u-boot/20261016-b4-sa8775p-qup3-spi-clk-v3-1-7b9867dbf65c@oss.qualcomm.com/
- LeMans EVK SPI-NOR devicetree:
  https://lore.kernel.org/u-boot/20261016-lemans-spi-nor-dts-v2-1-70307aab80c5@oss.qualcomm.com/
- GENI QUPv3 SPI driver:
  https://lore.kernel.org/u-boot/20261008-spi-v6-v6-1-2a8f6c05ebb8@oss.qualcomm.com/
---
 configs/qcom_lemans_snagboot_defconfig | 37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/configs/qcom_lemans_snagboot_defconfig b/configs/qcom_lemans_snagboot_defconfig
index d6906c1e501..d2cf1733bf9 100644
--- a/configs/qcom_lemans_snagboot_defconfig
+++ b/configs/qcom_lemans_snagboot_defconfig
@@ -15,4 +15,39 @@ CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
 CONFIG_DEFAULT_DEVICE_TREE="qcom/lemans-evk"
 
 # Timer frequency for Lemans platform
-CONFIG_COUNTER_FREQUENCY=19200000
\ No newline at end of file
+CONFIG_COUNTER_FREQUENCY=19200000
+
+CONFIG_OF_UPSTREAM=y
+
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_SPI_GENI_QCOM=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_CMD_MTD=y
+CONFIG_MTD_BLOCK=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SF_DEFAULT_BUS=0
+CONFIG_SF_DEFAULT_CS=0
+CONFIG_SF_DEFAULT_SPEED=48000000
+CONFIG_SF_DEFAULT_MODE=0
+
+CONFIG_SPI_FLASH_ATMEL=y
+CONFIG_SPI_FLASH_DOSILICON=y
+CONFIG_SPI_FLASH_EON=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_PUYA=y
+CONFIG_SPI_FLASH_SILICONKAISER=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_SST=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_XMC=y
+CONFIG_SPI_FLASH_XTX=y
+CONFIG_SPI_FLASH_ZBIT=y
+
+CONFIG_QCOM_SNAGBOOT_SPI_NOR_FIXUP=y

---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
change-id: 20261015-b4-lemans-snagboot-spi-nor-792da4e990c2
prerequisite-message-id: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
prerequisite-patch-id: 45d5c660b6e1ae3fb2ca1368bc70b4b0eeeaabdd
prerequisite-patch-id: 009028863b912df0340ab9d1f175174f6261747e
prerequisite-patch-id: 352f01e38568a6af4bd97af95b37ed385d5074ea
prerequisite-patch-id: 361ae6f5027197ea6d41d35d3536842674c5e196
prerequisite-patch-id: 198132b2faec33b113677ede4a9240de34a7384f
prerequisite-patch-id: 74241a7bb69b353f4041e72cf5dcce9e1318bc69
prerequisite-patch-id: 08a46f6093d2c4b245c07c79b3d3cefc955056a0
prerequisite-patch-id: c4efd2102033a65d68ff0d28707de86cac272732
prerequisite-message-id: <20261006-review-lemans-spinor-fix-v1-1-f61b32c1a79b@oss.qualcomm.com>
prerequisite-patch-id: 32427cb46dd12b1062cec464d5501c88d12224ae
prerequisite-message-id: <20261016-b4-sa8775p-qup3-spi-clk-v3-1-7b9867dbf65c@oss.qualcomm.com>
prerequisite-patch-id: fecf4904da8dd7eed5765399b20021e3a1a33c06
prerequisite-message-id: <20261016-lemans-spi-nor-dts-v2-1-70307aab80c5@oss.qualcomm.com>
prerequisite-patch-id: 0162fd68d2fa9e0aad579dfceca061e0ce7616da
prerequisite-message-id: <20261008-spi-v6-v6-1-2a8f6c05ebb8@oss.qualcomm.com>
prerequisite-patch-id: 55bd6adbe12e58352ffb81fa4759c209a7de587d

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

