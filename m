Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D95606A321
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OHGiMxP2;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OafRs+i+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ejhp02Ck
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91DDB40AAA;
	Thu, 12 Nov 2026 02:20:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yta0koffjnbE; Thu, 12 Nov 2026 02:20:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DC65540AAC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794450004;
	b=rgn5FzoNkG7ggf5b/T4ojCjkOLy4BFT98oUnAkMhUHZf95wSYvRvR9lu0KKd4ElUtNw7
	 sPfHpTRcW1Qv7p97QlPhD9J2U2rF8G60m6KsfhWaPg1HANb8MvTpAhpurUrlZUy+WuzhD
	 i1gAnMBJH5cNO1kjAebkSdr/D6O+0AF2q4zO7HargDLC3Xne3v4+6JxJNjhCrIjdiDgBq
	 aD/l9iK36DOxVWZu7dJwDEkxNToVmnXvMQLy0ql7QPegXYhxuwLpDNU00oYEOa9Eryvri
	 vxltj479KeDpkud6xrJbCWc+eh1WhnKd0nvBOloEA7RFjSN0vdrLVLcHKfWlq0gddqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794450004;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=N4YD8uM4rYr5ipuRYc8YbMnYpJR4QAnUAp64NsDXtNI=;
	b=gfwt5XaT3P3Vx2ZZ7K1ukOy8NA8YlIcQLQTBFQhcYAoeRuxAZpZctX+of74oUWrO+YtV
	 XB7u7m0xaSkCKZPhjs8h6jwN8GuN0wu4fWGkLiwN6zWqSoxkd+as76jDyW8hnKG6P+DRo
	 2v1PEI6Z0wtz2mC84YLsPWa0pyVr41hweLuWpCvAnj+dsh0BPI/1bTQGbKsvbeU6c7NQC
	 Zq3dFbH0B+ShLoe82K79zDBKF/gyxVk/a8AUMUBSqT1xzX+LafhSYM5D4yXjTGnBmqykh
	 i3yPI2gqQ/haUGoxujtrmjP0AaaewUN7o6In8MnjUGNirymE8s9wTQJNryFk4/l5GAA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OafRs+i+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ejhp02Ck;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794450004;
	bh=N4YD8uM4rYr5ipuRYc8YbMnYpJR4QAnUAp64NsDXtNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OHGiMxP2vGWiJ2hv/bYsVV9Uzo5i0pe+5qATIWyldiswmbylN0bSVho3YkfsiI14u
	 IC8F9ZZQrYBpIuIDSoihMtYoWNjJw/0+9ARKkroUVxeABtGdus7aO1oyfPX9uS7FjL
	 So4XPJe/GZwCX/wSIQfAV1MCRIaRHbY1jXTVxNKemQ/uCqvGhGM2ray0zUGseuYUz5
	 9DQkcfl9/zPPR+B8s1XqTQ9tGJ1PdhIX/BoByHpNJrZslvkwD0Hnl9ycAJbXV6yBFS
	 MdBEoY3sZ5luPTZ5xMnWwGj8r+oq5reMfkUvtPfOiiVTwVEfCaeLw0FQ2aUtmxtfwy
	 IIHL5CdP0pBWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC65540AAC;
	Thu, 12 Nov 2026 02:20:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C97022E5
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 02:20:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA16940AAF
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 02:20:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GwylSuQNxw1y for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 02:20:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A6C7940AAA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=urvashi.sharma@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=OafRs+i+; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ejhp02Ck
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A6C7940AAA
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 02:19:59 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABMaJMm395251
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 02:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=N4YD8uM4rYr
 5ipuRYc8YbMnYpJR4QAnUAp64NsDXtNI=; b=OafRs+i+VzI3DhkPvh0aNvnAbUW
 HrNbdqyBE6wqwRwqvYivPtONMcJ2olHQYmGa5VsHXfxh8PkjhwIt9irsGBXpKADm
 VKtXn/+8/SHOcBpSwF5I70r2rhY6ii0T2PHBQrndNxKxo6F3VsLTQD8ftSU32zYY
 jvyuzuyNEt3zLLGc44fvtd9qL7oBNHExqmVYJEerPYnVED97eoyQg3OySEbdpXJ5
 jYmDCvgSOaoaG/VvF1vL2QEJYsShuY6NOSthB9faryqB5ugUlzpJ5PX5Z1aUKnwQ
 8lUHNqarAS4ppDpatx0lobytaZa2HSusJ+u/V0lGARk+6spE46OQO5Hzs3w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt1uahdc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 02:19:58 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3724667bc16so271019eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 18:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794449998; x=1795054798;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N4YD8uM4rYr5ipuRYc8YbMnYpJR4QAnUAp64NsDXtNI=;
 b=ejhp02CkRbJMm1LdIThMuy+sPVBhZL84JzL/1vkuwu8h+bhFC5kUglxf9Vvsv6/2WN
 sgPsAE3k1s90d568ElmqkeM9AA4qmbtdGpMyk8h+TBtGzmgpkW4arWIvE2mxBC3MV92r
 nzVye/fr9jRhBx0zmIVt4L5PEZM2ROReA4CHpI/gSxJGqwo8hKVxq5VAZXVSQYJQiYnq
 WjMH4TggG2SyIwFMtRTIkfvaAK0zPk4Ajp5QZhg3/zRcyT6Sgtytth7loG9PIff7+voy
 wtZIzzwLkYuAeZE53H3OaDJ+eTTBa+90rpN7PFPKMrvyTArjFuiJhdAC4RAdx6PxNOu1
 nMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794449998; x=1795054798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N4YD8uM4rYr5ipuRYc8YbMnYpJR4QAnUAp64NsDXtNI=;
 b=rSVi/+ycVrQl/cNzPd8XwXZSVmC0w+npDFRg8pnfkFpD+4GzGeedZ8tpiGwB/2RJgh
 V+Lo4jWkcIh8jQDN1bMGB6GbvTVnhuYMP4xyDhwqhp09vPlgLnKNqwXgRHz3BE6Wk3W8
 blk9YqY/bWQ4TLGsnYkXrr03rpc6Hk5ZsT47SgkIbQKiWuFgdRK8OL/JFTZS4/3k/sZi
 tNJtAu7E2GteKO4mwFOSSFAY6zoVj2HVPpSuDnWs9ZG7fOieAuu10WBLhwapp/y2IebT
 XmVBMS5PSld88vgd6qFVr4BKxbvKtvLkp73XsJHC0ca9cKPohJjsI5pRkuB3/v+jwbbw
 dYpQ==
X-Gm-Message-State: APuU4Z9bXOeiu3t0Lwq9vEVQ5HfOj33iqqOyzxYguf5alY5g33a/tAHA
 cnd90svEHuP8fWDbcuCfBgfGiBbIpHSVoerb/XZk+UVIwMhEAmZNiMIky1oQ6zwv2YzA13Fr2EA
 E/Bpy7A3jPiRsvXj9Q1xzNh4A/Slf2L7jB+A4nL+Vi4X/kQwxrkBwXxmfk5hcNzRgTyYzFinmW7
 GI404=
X-Gm-Gg: AYBFou3JvFEx/R0hX1nCCk5ACasM0UL9C/AOQGRB+G5ueXstoaj452t426tWECuNkzZ
 Wn9QQLHWOI/TfiM6WTwQohOA8PPlojQ/OurnzcnPS5qrRvCHOaHMsqHfhJWsRRH82vsQE8Zmsvs
 kprimJw1F2LLwxXk3elHLgtRH5Uc45Ug+Ywc3WEuc2/G/s5tAav8uDLsmJBe+aKG+xBkGe8NHUw
 shBNpejJs3xjiDSJKEnJY50p4fJI+FvD1kkJdP18V3R1z5Pgv/QwUmQ7i+v/HSO7g9PZ9s2tR1l
 UKjtVjA1q53+uGO92aQglBbgyuH7ysy6DZ+RzdrO+2w+yMam3/Xkd2dFrxxZh0PDgcm0C6orrSq
 XEbMMTmPETUVO97rt1NgkNJeg1CmzNLQZjdJ+wk75lVG1z7Oai6J/5/yKbyFpTQbFqTPusp5y9W
 EB/M3NUDptHODK+x1nUQBfGAqSHxYkxWQ=
X-Received: by 2002:a05:693c:20c4:10b0:36c:fdba:ee36 with SMTP id
 5a478bee46e88-377e0452db3mr1139580eec.12.1794449997611; 
 Wed, 11 Nov 2026 18:19:57 -0800 (PST)
X-Received: by 2002:a05:693c:20c4:10b0:36c:fdba:ee36 with SMTP id
 5a478bee46e88-377e0452db3mr1139551eec.12.1794449996913; 
 Wed, 11 Nov 2026 18:19:56 -0800 (PST)
Received: from hu-urvashis-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520608b52sm18471341eec.13.2026.11.11.18.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 18:19:56 -0800 (PST)
From: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Neil Armstrong <neil.armstrong@linaro.org>
Cc: bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org,
 iwamatsu@nigauri.org, trini@konsulko.com
Subject: Re: [RFC] blk/scsi/ufs: scatter-gather read support
Date: Wed, 11 Nov 2026 18:19:53 -0800
Message-Id: <20261112021953.3971234-1-urvashi.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8296a815-d563-48f8-a32d-928bacfae98c@linaro.org>
References: <ptmm7jaltdwuyxj5ks26oht2cj6ckp4at6prvra27l4r6idkiz@xzyj2s3spx25>
 <8296a815-d563-48f8-a32d-928bacfae98c@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAwOSBTYWx0ZWRfX25pi5BsLMgu7
 ULAV2qr49edHevpVjS/5ya0UysrvydCohT1D8lwIA7hP0V5Ir4PpdpSlptz3Cio2gXbV63frqOu
 mR5jHxn9zD+E6/J7r2OHRJpP1cgZ1eI=
X-Proofpoint-GUID: ymH74n5SZnBnZAXzSXbC4WsRGiPkdENz
X-Proofpoint-ORIG-GUID: ymH74n5SZnBnZAXzSXbC4WsRGiPkdENz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAwOSBTYWx0ZWRfX4wPlS9fk6iyc
 3CuLEm2MD9PQX4I4ejxv/6Nfa88n1WnPUcb9t/F9ZmnJg5m3OtP9y6YWGadA4XLC/60yxtBuDSk
 d6nsTm5OWZEF2yCxeKKkqu3GxzXkKpc99e5mTV5NajMo7uqf1LdOFXD7QEkzUfuBSSeeucQD8uq
 3EHr1UkFGSTUhaNYa4Sw1VbhR2ckHZMovfdJ5mguDXWOTtsHueEm57ZcuCdxg2Xz+3iqnIku8P7
 MhFiReoUpj5D/gfmzJh0XLHh3o/mBEIwgwEoJUd9qAOte2BXVPt2t+0Y1XHvX40ZyC9MtaK4c5G
 skwYLDi2OjlDL8KRugkv7X1AkPFgTnQje2ZRxiRb5Rp53luQslDNiuwaqGQBYNytNkIiweAGRYs
 g3XNL3to84pbyc0aQeux3k316mlOQMKVgzBEm9TxE8OrZTlP5+oQRfbYj9OUdxan1CgFgfjM3Tc
 DqfRs5JeSrWaGgp5lIw==
X-Authority-Analysis: v=2.4 cv=LvcHWXdc c=1 sm=1 tr=0 ts=6af5224e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=UEmBXKKbPbeZTnDknQEA:9
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_06,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120009
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Neil,

Thanks for the quick feedback.

On Wed, Nov 11, 2026 at 09:14:01AM +0100, Neil Armstrong wrote:
> Where do you pass the the buffer for this entry ?

The addr field in sg_entry is meant to be the destination buffer for
the entry. I'll type it as a real pointer (void *) instead of
unsigned int so that's unambiguous.

> Maybe passing sg_count directly to read_sg would be simpler and avoid
> an intermediate struct, except if you want to pass some flags and extend
> the sg read.

Sure, sg_count as an argument works too. I went with a struct mainly
so that if we need extra params later (flags, alignment hints, etc.),
we can extend it without changing the read_sg() signature or every
caller.

> - the naming may be misleaded with the "sg" dma, maybe instead use something
>    like "multiblock" ? I'm open to anything, including sg TBH

Multi-block works, but "scatter-gather" is pretty established
terminology in storage, so I'd lean toward prefixing instead, e.g.
blk_sg_*, hope that would help to make it less confusing.

> - could you check if some other interfaces could make use of it, or
>    perhaps if a dumb helper could be added that would simply go over the
>    sg_list and run single transfers to emulate that so we could have
>    a generic usage of sg_read in FIT loading for example

I looked at the flow, and it's doable to add a fallback that loops
single-buffer reads when a driver doesn't implement read_sg, so
callers don't need to special-case it.

> Please send a quick RFC to we can discuss the details.

I have a rough implementation working locally, so I'll clean it up and
send it as an RFC patch series.

Thanks,
Urvashi
