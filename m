Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74567606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fttOZPeZ;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MB4Usmog;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hpgcsr/B
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4958D60848;
	Wed, 21 Oct 2026 16:10:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zgg1FppOoGtp; Wed, 21 Oct 2026 16:10:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 46A7A60856
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599030;
	b=amGd6PfDaqCtvTrkhsMUOmMgoN1jGdgwoZJhCOLhgpr12z/TPdx21uVGdBpT0JDy8K6A
	 Zx4Di+Q0QuTZ83Sa4iXw4r8s0Hn1QQg6W2XwjIBn1ZlaCUnUZqcwmgzl1Ga6tmtZKGjg/
	 klJ7WtmAirGfR1lOTDg3vazrZaOVpF+0AG5iEz7/ncDZKPk6HCrlonxAawya4VjqAwa/R
	 YtlqYJ/FEc2Ra0N02Nf34/D0OMSl7cj0CGK1KYWdMJmYP/9YTzZdxOn6lPiaLHtSKQ2q6
	 ZFu2XpZlAalz7c10hrNP89sgtKhFfok43rqVlJfGQKs08BuZ73antJgPrACpm6wSm2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599030;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BVDvvt5937uOwhGdqdA5SY9iT9QgzXHcBly72btqcjo=;
	b=LMLh8mWsb5K0dgbAqSFLLJuTIhloC1BOIdNSiJOx9UVQC7CWJ0kOsyGNSc62StdQzAUP
	 fS88T8dKBncAY4fh6VeLIol/kFRUZELgDzlxROOuwfFFJsyIftwTTo4COoQ6qSmhzNIrh
	 CrGzajgLt+vmgo8dN0qlmIcQ4+6y9IfV+6DPOUjJcdON5GBl8zdpmPoumXRmySLdEps9D
	 5iCPLDSRB1Zfsvxf8TLS9qIKVf48qmV1ld7De8a35rjOFQ4cx2Ko5FN0LLeqwpOR+F0BE
	 AkNKbS7WZE7RsOv7BNvZTY4NoRdP6rhd4OXxQlyk18I8CG0j7ApOlQDk8HqKsmSOKfQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599030;
	bh=BVDvvt5937uOwhGdqdA5SY9iT9QgzXHcBly72btqcjo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fttOZPeZGi5bBwKpEWj1/R6WOzzz+KU7aaBeoHPC/2cid30KL5OHSRU3m1sxIGySB
	 0xJwK/n9uJujvza1APYRXwIquSfW0LXfGI5lzv+atjcG0q7nDrr7c29a85grdRUy8u
	 Ddj6cbxGwAy90XiDepE3Wpyhv3NWq30MCJnc2vrwDYLvdQk4AFrpMFkd8CqClkzemz
	 tCMHppwD0Y0XrhTec9oIbyA3Fu5uYYsgkMhGRu4taf2W8SIJbTNrt2N2lMvnt0yDuh
	 h2jSNMHuLXh/fDEHhgxklonHhEL8bAzFKMWylQwvpB4joo//hhvEl75aBQaMJACNsv
	 Y/tDjzg7mb0Sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46A7A60856;
	Wed, 21 Oct 2026 16:10:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 20D3695C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 125D14039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oX330Csp-kXt for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:10:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3DB2640077
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792599028;
 b=H8Hxot41sgcR9V41dr3d4861qBbgVqQ+7A6olkKZTJrs9k2UydHdWhI7APMG/lk56Lqz
 7/vYZXoJvcpS6k/8L7ZRa3/AM7GtlkQ7jzS06eGSUbKfsVYLjqGK3yb5Osgb/QtRK2HSF
 s2acJd1UoU5BRPdDpXtMMhoZMM6fCJhtWUEjqbca0zQ2k12WdNhQR8EmoQuTiDw+5jpK/
 gWMlaGD2GTUPcq9zflhLSkWQ69gDcgBJyQBoLGmUPMUUI6sW9SP5O3UrQjI8rUddP/Zhc
 Uq69VOlJVoFVyp8Ualpn1rZGIY3RoADIViVacqAYrIdnl2skZGMPiRfyUC+QbHGWNFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792599028;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=BVDvvt5937uOwhGdqdA5SY9iT9QgzXHcBly72btqcjo=;
 b=h2fL1IjkFdJs/QHEYsf3Qbte562OLSX4p4uz6hgRG2RnaCWNNJOuQsDLdrb2enh2dI5L
 MP738l2P08Fs4J8UjkMNYeKwEpU5E2qsUNFjG0NuDQc44nSOjxsSE3GvbkOOspw6rG2dy
 uCSy9msHeU8m7WBZFrmK/C1f0c6188LSF+P619utAaK3JtP9hBgOVhDwbnRYQkGBytyCI
 nji1HjV5gANGIyDUNZDULEtsees/ES2XwoSbt9aDNiRayjkRo1AE2dccPFrt1AiN1Eyxl
 T3wnqgNfCs6W1PfdHtkv0IHZ3dH8fXsOeVb8OcD0KHUKNexlNzy2qbNfKVcfyBRORWQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=MB4Usmog; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="hpgcsr/B"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=MB4Usmog; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hpgcsr/B
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3DB2640077
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:26 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU9MX1481551
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BVDvvt5937u
 OwhGdqdA5SY9iT9QgzXHcBly72btqcjo=; b=MB4Usmoglym8B67z5AKDphsqPmX
 ApRMoxRiZM+O0WGsKv1Ob7Kc0WkT3EGcsOrXzA0epGUxSKshq7SnN0qww48uz1j5
 gvvCQ+Xijrua9Uy81nTDQfle9xhIqIQH6S0zjgplPdHalnyEMDLPf39rih7kx5QH
 Pe27sqsDcB0CVFS2Weh1AWTrkHzrgJZhcvt1RP0Mm1NhtrVQQAxUACJvSxiZf6XR
 YJr9McjUJtlgKqXUmuGfYAxAPEB7H/VYltinysunz08JJzU6HG6H09Dwga6ewjya
 VZobF/Hhl1lgz29SGbLp8+Mq6WyheYi6PzUQTA/2K/KLjcpTTloyHD5Vdew==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hegs043yy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:10:25 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so451669eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599023; x=1793203823;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BVDvvt5937uOwhGdqdA5SY9iT9QgzXHcBly72btqcjo=;
 b=hpgcsr/BdLI5/+juuDsel2wrzPw1sKtnHmo2KvtyjLhW3vRXJbqsfNsV4T0/5h0XxZ
 rv8m0fhbsGFLa3N/qjpbx8h5lkL93G+wJnzY7Km1huQNaTwsyVwdU/aemBb5+oVB8twv
 9RHKLBJbzXrHFic1sHo4Szr00Cg4onFatPltB39yX6MjXqAkBtIVarMog/hRvkQSh3kl
 nyZ+WqwljAiTx0XovTH6C+AAp7bbXAWnjWl69Ky24ijFekveS8Y9RjeRRSbhLAuTDQ/0
 tG+EG0Vt4Ehc+uWOxFGkekNan0edN+EsOBcZ26/uZIelM17slmp/1Fv4pgl96yWaeRXS
 VuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599023; x=1793203823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BVDvvt5937uOwhGdqdA5SY9iT9QgzXHcBly72btqcjo=;
 b=NKqBmpFCRPvdgO+VddRx8k8sm1iFksPHRQCBPcKphjyrRDo7gWtziOHZM5WLsGWjPX
 wHUmPFI7+vI8HwJIJ5Yk1JhZFXDCSldaEA2Nyk9vYOxRB1R9U7oWMEUTRMRUAmrWVe5z
 K3jT09UifEuV/oZpV3GcsEl19EY2AobakhZD8oX3aXCP1GQe7wiBmZL6Qn/jj9TJ+bja
 U7jydSVJzAYolvSa0gR/Slu3vy0E4HTQ/JPrlrPVN2WoB2TAseyOYFbe2N5b/zyX4OSy
 by0GgxAIgytYIPuQfUDGjtFYRAryAw1RnfE4870O3i3GHwf0f++kSKuUcZS6UZkaDqPq
 iZBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBymtOKoNBkA8jIb3MPognKYU+T/jRrybvaNePgLW3Roa5Snv6aQgTnesq9MYjHFkAblzJkWys8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKS45nuBa8itTW3Lon4gMTROBqLpjnoPN1wDDkYhzu6Ok2OHYDQ
 PkKU3rog9Oiuktl20iFaLER0XUgVw0iGFaScD9GkJ+/ZiH9vwe4h9W2ce7pQlmWV/Hq2+V8MaN4
 ZSf/isVAKu+SPbeO6oqX9Kiy8BDyEnTN2PsFk8wOIDLpy1JjCcixaZsH1UT9+t91wnqhHBKs=
X-Gm-Gg: AYBFou0TtdT0xuFcPc2xO2K5chRko88qo2rS6VrdRdZtOti0iBCHtHEo9h2egMNywx3
 uQ9mTGrPp1PyECcwfoV2OooLWL8yuJFxr6xj/pVAIOc2tTibyVYe4U5Dd+6ZM1ip0FTryI0Bwah
 JaIZyGhJ8DgWDn/xYlcSBuWVNwNwNayyknXPnRVdJ+VH6yDyC7yR1EZnH95gQFAC6WeK7s9x7oV
 hFbHZz17UfhHyb/l/7XYX2DCHEoKUmiVmNNUVxxu9YJSjGkAX+n7wQZUB6E5oqp6BgPG0Nq2u4l
 vcUrE1CT0V3X4C7PK/2DG6bDGh/PO/PElGjSPKBcehkSqr4r9gEBntfwtD1IE1J+tghQGXWijVr
 FnpbbCffxOVJHXsMtwyUM+RBVobnnsLCcVfQsGAjlk5stnwFFWyANr24H7AXhW6xjNc05lR74Ax
 rdUP5mNYLarVeKvJg44rk=
X-Received: by 2002:a05:7300:d112:b0:359:861:7cbd with SMTP id
 5a478bee46e88-3674c93a449mr3288601eec.10.1792599023134; 
 Wed, 21 Oct 2026 09:10:23 -0700 (PDT)
X-Received: by 2002:a05:7300:d112:b0:359:861:7cbd with SMTP id
 5a478bee46e88-3674c93a449mr3288550eec.10.1792599022300; 
 Wed, 21 Oct 2026 09:10:22 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ee5e3sm8216884eec.4.2026.10.21.09.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:10:21 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 william.bright@imd-tec.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, nathbappai@gmail.com, macpaul.lin@mediatek.com,
 jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v4 08/12] tools: qcom: mkmbn: add Shikra board mappings
Date: Wed, 21 Oct 2026 21:39:12 +0530
Message-Id: <20261021160916.3894471-9-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S/NMU4sP c=1 sm=1 tr=0 ts=6ad8e3f1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=1LA7DHwFGBrveulqWMoA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfXwOkR/oMuYldY
 HA26D8E2LYHGip/sISv0gbcvEFcpPShTF19PX7m0ieCAK9Ayr/qzbs9iscBYAs2FXg5bRe+RGJx
 GkLV6mFpjX9txhq6Pi7lTYe0nI8+UIfx6plWFcuBEn4SJWm8C3Ih238sk3+HAukwlN0oyPLuF+a
 iAN6J4OlsY/sgjYZuTloimwLtts1ZlKELIKv1WwbVB0HS4K2LyUihSLUSA+Kn/j0r/xk1LwHQQq
 0o6h2IpH6/1YlMVF/bZVoIT299FjLyjblIVyCe6DbCDrXDeiPXW7c6b1XU8OJpkUEd/CRiO4LDi
 PTFSJTmpPjvpEcrX47nrHMU/Em9rBjm3U6M0Pmzc9MNgYoVWCovBx2sDpJvG+qHzidZve6MBaWl
 9Y9CCoJkwumUfftb4lk8ogpheTYyscAGaTdPRmYPUK8YlfUX7/+547MP0Bq/LnzAy3hAfiPowjU
 4KL5ALOEoIRX9mo6bCQ==
X-Proofpoint-ORIG-GUID: JV8AW_Hf_1AtPw7ObV9po50Ke03Aqwh5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX4EXB+P/vPqEe
 wrXtIxWvr2HSVy6JGlMH5v1qMLptnXAWFRm5opKy7SGQxihic7N09JJkw8w/MZvaEV3dp3AiTQr
 ktwX7PYBvnUt3B5l3JEc5vYGxFbzwxs=
X-Proofpoint-GUID: JV8AW_Hf_1AtPw7ObV9po50Ke03Aqwh5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064
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

Add mkmbn entries for the Shikra platform using both the board-specific
compatible string ("qcom,shikra-iqs-evk") and the generic platform
compatible string ("qcom,shikra").

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 tools/qcom/mkmbn/mkmbn.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index e4484b539b0..2a1978f4ae9 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -76,6 +76,7 @@ boards: dict[bytes, MbnData] = {
     b"qcom,qcs9100-ride-r3\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ9
     b"qcom,qcs8300-ride\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ8
     b"qcom,qcs615-ride\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
+    b"qcom,shikra-iqs-evk\0": MbnData(0x9F400000, 6, SwId.uefi),  # Dragonwing IQ2
     # Fallback/generic matches since most boards for a platform will
     # use the same load address
     b"qcom,qcm6490\0": MbnData(0x9FC00000, 6, SwId.uefi),  # rb3gen2, rubikpi3
@@ -87,6 +88,7 @@ boards: dict[bytes, MbnData] = {
     b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
     b"qcom,ipq5424\0": MbnData(0x8a380000, 6, SwId.aboot),
     b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
+    b"qcom,shikra\0": MbnData(0x9F400000, 6, SwId.uefi),  # Dragonwing IQ2
 
     # msm8916/apq8016 has an "aboot" partition but the process is the same
     # They use header version 3.
-- 
2.34.1

