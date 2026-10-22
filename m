Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125EF606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jz2aGD8x;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bJIsOHPU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I+dMnh/u
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E23AE608FE;
	Thu, 22 Oct 2026 21:34:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id neVkzDZbFsMT; Thu, 22 Oct 2026 21:34:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 34E51608F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792704881;
	b=lsdrK6GqGAWXfy2Oci5a+uWoVL6SY6f1K9pNub29RFBa240+osfN+Et5w5jJIjR839db
	 NB1jmHQYYo67rK1JeGVmI0K9b0ggogUWT4bfdeIq+zH7bqLXUSxGc+nAaKukU10bzT9D7
	 hyA7BEXwcQpsJzjF81rIuP6R+jc3hxl2XLZJTkIdAXY6Ay4u4yeQRGtkluTvsMhalDstb
	 RsXo41el9o5zeVUdKQNWgQKRE3B7d5/esJ48c2X1NhKnqoqJfpuc7D1YxFG06obEgZTDC
	 VfXdfFo1TqEQC91bQdyUcjThsLVJ0uAmiFEaHhr1Gdb2WMBjxkymdAlPY8srpxU+zqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792704881;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+dfHucpCe4yf8ZrGIfqCgCtQJFE+B0cA2UC2oT2x0zk=;
	b=EeX7O8T6xuXy5S/2f7JZn+BEJ7kcFw8RX/z0vrAqWIrL17hQb8Gd0yHZwiB78Cl7+H12
	 y0tJejj3ntaPgBzdmAtxb9akhKXBNI5zwuVnnmmwLKUXxLe/omSnbEFDQwAWRGpMo6jlx
	 ot3CdIhHXkpj4d248frUCNxESdF1kYT+40OMQehXCyMz2uFr+QiIS8Ub1ys61vSOidvMm
	 noppejaio+aOatOUz/0jhHXJEfOPmc8gOs2dcrJqZVW6w0WMpMqWFKU9r2LJ9ZefzLLoW
	 fL3ixN2/qkmEld4b50ARVauT70szXYrZIJJa2aeaARCxcE+pgkSbhuWNX2vZLZbsjCw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bJIsOHPU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="I+dMnh/u";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792704881;
	bh=+dfHucpCe4yf8ZrGIfqCgCtQJFE+B0cA2UC2oT2x0zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jz2aGD8xAHKoxC68QMVpN+RSyTuLM+URHXbmA/QcBRxvlaulp6/G/96rNN7iVWEdY
	 S3TlS+Iy6+MGtDuGvyKucy8l1SM+S2DsJqUdiAjqOKRsJEZvennnIWsCcBb+o6EeZQ
	 NsjURZWgZtdqVQgAbR5YElxfA2IT1Qh2jcGhABtnIhO5l7W2pwBIiJ1WY+Sa0xJEpo
	 odvqhkC9wTrG1OgueNVJwlTEPvLBu7GZ4PxGTjz/jzaydiC1acIW+iqnbXe7uhHEmD
	 Jx/Rl9bn5IBBVUM0hZIqKaHNMIg6RndMgiLEanAoI6+tK9xWTVH8lAuibVF6Rqvciy
	 DcX2MnNPQy2ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34E51608F5;
	Thu, 22 Oct 2026 21:34:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0603D4BC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB5DF608F5
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T_A5wf0b-jTB for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 21:34:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 619DE608AA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792704879;
 b=oNubzLRFeaeqTcm1v4/Jxfzyor52GF2RHTosai1gnfdQGxxIrPg5daJ8Ip62SIjDCfYJ
 eNtYakbsDcIpYjWAg+kV4UJR8Q/T9lWytWvvq7xCZ6kXZ1DVRj5GmH5UOsIMq4erXdAEu
 HU9egMEC9TJTXHwm6woossTTA6m7npP6RFjX5mo5m5wRJf8eHur7IXAjJ/IaESIo18ZH3
 BZD+Z5pl/7ucwB+fT6syzoO7GqJZxP80RmPPofbQm7u31qFKBZEPVOvp1Cvv9U7jL7n8c
 vIzzZXvhBA2qlVX/jA++NOryz7i4VkWXi/c7JO7h4gfeOi4mYDQDT+i12t0aAWa2Veg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792704879;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=+dfHucpCe4yf8ZrGIfqCgCtQJFE+B0cA2UC2oT2x0zk=;
 b=H1u0byI0eulcXWSQ3WloDR2pT9zkG9heXSRRhpsEEZaNhPzirP7N0bgp1yzQQYO0F5zK
 xL+Ec17vQyJjHkci9BJuj1d+X5l3YO24lV/CQC67eXBzBFSNppG4V4yjryprhrtwGHGTN
 YZU7EWrSgMsP/POXwTBMVvpFWTHruXSKHGDteLiu2NZxOi340pqQjcD5MWt0kuKq1l0rp
 2D71F7xoWG0kKoaj54ImLFV0XN7TsUe58g8bSgl4fVrs6gf822fOWYvxvVmyXW74U2DL8
 MDtn+Vr79jn/k6CQtvmbz70V4Qe2+s4S9jyZutw+NUS/li4MCIH+ohXfnvgJdW9Ushg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=bJIsOHPU; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="I+dMnh/u"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=bJIsOHPU; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=I+dMnh/u
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 619DE608AA
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:38 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHANk3741647
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +dfHucpCe4yf8ZrGIfqCgCtQJFE+B0cA2UC2oT2x0zk=; b=bJIsOHPU5tQMFX0q
 01nLxFeQvADs87sxGgOwB7n5k5BQCwfRahp2T+QkFy7NAeOyVFTJL52H6q3HzaMx
 /wRmaX8NPZIsuRJ1b/pQ810e7krAWps6Zf4aMn75d6+PAj+O/V5nSonAoIs2fyzQ
 nsi/obrDaaQI2TDS0HmGsTzjChKJY2BnaoEgJHpUiotHh+5OeMGBWb0/SYyPd9PJ
 +lFmd5rX2fF0YSVhiSQ/JzEGGRY9t6fTHv1HUN32hx6VjarIJ8vRAcIHtzgCSAKR
 XWIyGhlxCg0WTs/UyGY8vKs8qwu6rgHeLouGKncpqLKZDYnyazdcHs73TUg8sfiu
 XInNpg==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms0n2p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:34:37 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8ae5317eaaeso5587567b3.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792704877; x=1793309677;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+dfHucpCe4yf8ZrGIfqCgCtQJFE+B0cA2UC2oT2x0zk=;
 b=I+dMnh/um9BG1eq7u5i925Q1R4SyRXib/s1jucq9mqWbjRUHGH249FpQOEoWytfrbt
 XsSG8K/R7dSyUWd0pgp3EXKvPc5ZGh5/V+85MricepyKIkao2rWItHc44ODCzb12Q8ev
 9lV9Tlu9qfzfhWF6VDOz5T1ARYFs6ahDXaj0hiByw9Apl+/mr2ioEYJltT+ieJW0P7CT
 IMOJHluyKvBVc4XeLYgeTgKq6HqepRNhEm8m9cqYpR6sSYIhA6imW5dK6sArQiqbBvkR
 rB9owBxEqO/LYbwuszxTUxW62gmjNPpx2L31A4Qsz3Qy7NOFIoQZwMl9CEeZCFvk1YYv
 0ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792704877; x=1793309677;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+dfHucpCe4yf8ZrGIfqCgCtQJFE+B0cA2UC2oT2x0zk=;
 b=Fv1TQQ3DjoQr9M+UhH8+qta6ov9jom0YucUVbCKtGIyXneSOsJ0w2qwTKAVG1MgSHk
 kI+U1/NlWZ5LBbTI4TxTJGQ4GJiiqgnpaxivhzscNx6pXwXSFA+je23sqoBiS2f4rGNs
 la1/tydCsiP9GxwSbH3Tpl1RXdPBs5Fr+to3UPeW9RhlOh4gSWgBnT+MiNK6kuZfu8Ml
 jd1C9rLkChDaaNw50njw8iiqiqH+QI3vUK4d2sET/osEnh+n2PwF+LScBx13eYWiUDt1
 UIepcJplQbhuQOUDjtyJkYNex1s6D2u0HC5Xm1K2BeTiXLTGaxonT7VcUTyhSnCzZm6z
 FcQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvEt1SwTQqDwjK+PovcIB95J0BQt7KG7zAdvCWfDs/mSrsiDTHej7FjMvGwajRMvZIZHOpZaI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKFkMjOdzDhwzWTlqKhJ5yL2M52IOmLXb/r5z1KzxQB0TD81ea1
 lDmsyJ3inK9JzxxrioYF6HAe3wEKDtWtzOy+dDvNLI7xvKZ0YxPBfyE+frG1fqTCDdPN6t0d/lH
 EWVzbAPxQ6uERrBB+2HFcW6lU9MtVF+MOYUGka7gGSxUbYPviqcJOv22Aqo+k4QnbZ1ULYSE=
X-Gm-Gg: AYBFou3dW6Jq31TQiKRV13ueo31tYGYY2YNuqADGG5lymtjGcOVOe15P33uAOOt/H8B
 zAHQ81K/Q1DueQhbcbrgpYt+QLN5nsuqS0xmSlkLrgdbwCPUqdIRUIpiy8AdoH+ZtEN0D3qjd6x
 0h+8tgnRAeY7EbdK9ozv2i1SjUd4fUybz3W4sU8Utnos0ji27E65Fvdq5Tqf4Z2pioytRXocGyy
 4ATbqGrMODb4uvefQorG2nN18b6CCkiMeHzDttirKfhRtIzZvC2JBrrCqh9QJsqhq7X9YhINGr2
 TQOn/o1zFOKNKTIpd0E+xnXwsOPTuAcTI2mdPel3hwEcwNULnfI+5sNCZFYGpYFvZBFvh6EEG4a
 rwDOdrYg6Ich/T67hq7FelXxbcM2b49p2yy8pYqrnxeWWCWcjGnV+8iG7QNt8
X-Received: by 2002:a05:690e:d4d:b0:679:c9af:6d30 with SMTP id
 956f58d0204a3-67a35c1465fmr171294d50.54.1792704876996; 
 Thu, 22 Oct 2026 14:34:36 -0700 (PDT)
X-Received: by 2002:a05:690e:d4d:b0:679:c9af:6d30 with SMTP id
 956f58d0204a3-67a35c1465fmr171276d50.54.1792704876447; 
 Thu, 22 Oct 2026 14:34:36 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67a34045843sm341787d50.18.2026.10.22.14.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:34:36 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, nikroks@mainlining.org, luca.weiss@fairphone.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 6/8] configs: qcom_defconfig: enable nord clock drivers
Date: Thu, 22 Oct 2026 17:34:29 -0400
Message-ID: <20261022213430.765933-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021160448.3893858-7-aswin.murugan@oss.qualcomm.com>
References: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
 <20261021160448.3893858-7-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NSBTYWx0ZWRfX0aBL49HJxZ9/
 K/dw/fgLKkudt0djhjz37Pb4m6LNyZOy3N/tJ0nhIc8cYDZkWyTcOpj7J379vRgMxIbVeYo3LPO
 G/kZAsd6+nqGXQ0Cl3+jt99K3aDww3xl2xITdg3Vm5D+9YUTyyz6vUpRsO2jt6KUnmOknFfWsRF
 P7/WFYfi1Jt6sXBNKxblRkfdr49PSivPNStFODC2FwHaOXEFU4bf6PcYlG0IsrVcSlbVD/R23Yh
 kmIhOA39m6TPHth+rSUNQrjA2nHbZjdulDPxZqaKPpUdxHEPTtYZKI/nuwGzWb2mIGS0dMrO2u9
 d/vY3EqexD/6IWB9RjmUnkijKGuItVDntWxL4NgZHCSXUGOUrLPrm4e3DtujEInkJ4MOT6A05Yu
 txxBUyT/RsS/NCb2wEuYqZOAZlQ0VSTsINWrY7hYHGcjKV7kDVva3/xipX7ijXH6jN56VQMzLfh
 G0/5V4fRNZc51IBmeig==
X-Proofpoint-GUID: GtYwY8LjXU3oAzgOao3RnTEUOp85DM89
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NSBTYWx0ZWRfX9VjgjBZeGqub
 4lwd6incYfKBrDPRXzCUCjrIgaG7vi9M4MX/rkHUznrS39EgxFF0NeZn2KYv/Uy+DAksxLCMjoY
 YpTK7yAbuibxdSJVuTzsnkXxI0HgeoI=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6ada816d cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=RVtJIJToYqnh19CvdeMA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-ORIG-GUID: GtYwY8LjXU3oAzgOao3RnTEUOp85DM89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220085
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 at 21:34, Aswin Murugan wrote:
> Enable the GCC, NEGCC, SEGCC, NWGCC and TCSRCC clock controller

One CLK_QCOM_NORD for all five, like sm8650/x1e80100. None of them is
useful alone.
