Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDC1CCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 20:51:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7541B80F40;
	Sun, 18 Oct 2026 20:51:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cmTNVQ0qXggA; Sun, 18 Oct 2026 20:51:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8BA4880F59
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792356674;
	b=hENJCnKaH4F8zJUjoV8nbDGrl9qhyt1YnoFFlBFnkoaZJnEYsbBUXB5L2PnWTmpVwmU8
	 NN7gVg5u5JpkJe6PMgNPq4dtoTkYleql98pqxGLm7R2yNLttRT3VGwvqb80PT7rSA976D
	 Fcde9JA1b1p32d/fiNx8tWtfYZ0J8vgYJ5qNdXqy8KKsuTPXvdUlZCwBT99NnMB38WIcC
	 gK50cQkWGZ1I0WUhQEcJ7jo+PYCJXGTQIBuvxGFPMFoHxObnz4MBqVA2mMGPyf3A9v7kS
	 G3FxZDRRN+2kaCfTdvWhZZqs6dMSH3G4fx1zMOTpan92VHukP+ag+BP7RbLO/0hHX7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792356674;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=f3VT/OmXyjJzvauw/4695C3QicD/qqlNjFZH7o/LQj4=;
	b=SJRp+lbwG6RRClvqwDO0tcNNsQ/BF1+TCb/zvOJfL1ZzODojPQPB2tuTeT5WabTf40oI
	 uvZ07ocXQqXljbhYhj+WJIdW9TeOTdeWX4PdnNo50gZ/W5eDabc/C3xmzF4PAmD8G/O5M
	 OttZdDC3uhzkkpzoC1G7AS/JsBJCXUM3WGDa1h0zIn8Jlh2mqMToNfEFHUCm/s8fiXaXb
	 KM7fWfltDPtUCFGmfhr8FlwB9HtjSgCYjkIlEgQeAw8qCdeif9o12JzZaT7uhGgm+/32w
	 zNpeWJ2EGHmFqGWeFp72oonZMCUucPliVI7LaayxnUkaR25YbEqZFbfu/XyNS78FEVQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GuMnforg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="f1G/Q7tj";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792356674;
	bh=f3VT/OmXyjJzvauw/4695C3QicD/qqlNjFZH7o/LQj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nd+cHKE0K2eVA1oND/nSI8ic7z7rpHBwx4utl5PMLv/yCx1E0QLT9qTH/VXkba4lC
	 YoqG+rKIbHUpsnZ5HdkoavTCvrFstwncOm5IEdA4lfRt1SGFuqeGyk9eBCMKXIN+gj
	 Zr6TcqEq7RXur8e+fs/WNHnJd8JeOTaa4CaXljfI+dz8vIpzAViioe+xt1zT4SpXOy
	 TqSyEqueX9NRgKYv7UNJc+D36XIpbygUqTvR46BfhCSBq30XIyrpwDgQ5Jfwlgw8J2
	 uYx9ZRnIZwmj9M5AXhME4v28rEzR3Z6dDlaEu7VgLqJgKUiLBEwBY3RcrD/bFJ3Mow
	 SEEDyUHbLU10w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BA4880F59;
	Sun, 18 Oct 2026 20:51:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AA53F769
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9BFA280F40
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wkZt7K771S-C for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 20:51:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 63D8780DC8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792356671;
 b=o+KL6BicRlFGctkrVNh1x/q4JIIGlcwZK2tojiuRWOHW1lyGQDR3/ZAEaQrwpuJTfyCn
 bUj2hw4sXufDUieKJX+W0BV5EKV5YGkmiDvL5Eojxn4jdaTS4nWGsbaPLIpIVoCcNJ8Rk
 7+4+D8jaWE5Jn7HV9mVvh/5vkoGQ1ZenU1JU+eI1+w12m6nhoKSvkpYRS6J3T6ErYMGtu
 HgLkCiFfC7V0S7o7ZmZWfDiGeLn00MAObPwuODaaLDIwPnSqTcETw4K06qYsU9t1ju+mB
 QBPc7CuPiNv3yVgcBOMUK1dqL4ZjrVPW8a0MEqc2o8VDJlnoo07csz2PGVt9eZO7NFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792356671;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=f3VT/OmXyjJzvauw/4695C3QicD/qqlNjFZH7o/LQj4=;
 b=qg0IyA+XIF1DfyXI4twNXml01G/tPJxAYl7EbInNUGUx3lbUEf8kP+ks9ayg3IUbtMnp
 OCM7/UzqBiam9brx5sTWGY9lpNZwCBiXBkypO7Io8pSjWU0RqhQVX3zecWQL5NSWK8GDr
 0020Y+25PtmYYSMedE0CGAN054CNhtpKrdjEu8xkBtIGne8N3m5qeJ4cU+6GM1rgWiI9e
 36kgpqY/2YcQlVg4cM66f+0cEcqGbUJZghSYLnbTiE8afJpMbyrm7kl0EOltHZeQAieks
 C2MDqg6NurO2a5E/FfdD6/WFAFvwWVjPfFACF7EQcZGUbXsmJt/Inf+fEL8TgFLK8Fg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=GuMnforg; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="f1G/Q7tj"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=GuMnforg; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=f1G/Q7tj
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 63D8780DC8
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:09 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69IKB2Ko4003787
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=f3VT/OmXyjJ
 zvauw/4695C3QicD/qqlNjFZH7o/LQj4=; b=GuMnforgPIHFo564bgQYri0t5hR
 Rtgl0AjcT4LTkQFLogq/s/N/1ipiWE87XELSKEQ/VlSEUmsWLfm0y+gYWkFRFYNK
 ZkP9yf5shHfUOnY/VxuxWCcduVNCGdTJu4xvdWl+MC18ld0xjq4e+dyONOQOnZfJ
 rItWgObJ64dlBgjaATM6vz6ydIi4oOO9o2daIFAd0959GhamP8u2Mu13H+7UOTZ5
 YRqz4TTSaxL6jlN0wJVk9i6ZwwFQ9kf+Qx9mwszJEP0wv5imy/BS9LiltdtmQD8h
 88JF+E3lMUj6Omj9l1rzj3cVnyDoTjUIvhqV4f8sqm0OaNQo+Vnc9neVUvQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc2a9kqy8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 20:51:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e82060977so307069585a.1
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 13:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792356668; x=1792961468;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f3VT/OmXyjJzvauw/4695C3QicD/qqlNjFZH7o/LQj4=;
 b=f1G/Q7tjxNRPH4vEGUMVFoBnux+4HT2BmcKOPJAiPeNiHmO2gJ4vNYkd9V73ZrTnzS
 QjnmN21Li0KYE4jLsnKpbsi3ADLNiOWjvWwMSX/8ePXAPEhdHCRftaFmWCUkozB4Tqv2
 b+z/BPa4tnvRw2TtebSFA9ELVYnn2DZm0x6QPwwYHsxX23sB46T7s2ope1Bg2B6HU1Rs
 bVKXPg6kjSD3vgGflCETc2YTI65QA4pSxoUPInwKtdBAumug5Evq1/awOyzWdEw9nRsl
 4k/zqhwNsllxa0QNuS4OJlbkFdorA9KtuH0aKjYCro3DzMFHTAG2s7YsNV/KUQkI+WrK
 Ay+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792356668; x=1792961468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f3VT/OmXyjJzvauw/4695C3QicD/qqlNjFZH7o/LQj4=;
 b=JHSrKhw/WVhZ3KZc3Zh2mqHzH1MNDzNiQeTmVWqt6nvPPIXRw685snsBVeO06fF96c
 urMW2tkA7ARuydwJc29J4N+ZI/LBZ/2TuFGEpfe1eG1JmfXOc4jC21HWu69Wy1CuGhnM
 LTRun/U9PF5qlHPpkPD02bLGxaTDsdy6ljHw5aJ4ptR679Ntat2fMsuf6ER3LHrrBiPo
 ASboAW2fUfd5/XkDuKiFTFWMsT6+r/kiApzOpQqgGBSUxmYGP2GvLQ3L2R9UEUcM8psB
 2iaURsYEpYgHgAZ5RsQEg1CQEpWT/wMk5y7nnWRaeWzpLti4xV1wvaTnDt4+nz0LOdBh
 iqnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByP+D9TIkpLO4J0Twg07znkM9kovvgRBHKuejEwDltwjYnR2CVN08XYBBtNoDdpBEotXLEyYpg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLBmPbLg9egs5THeb2d0rYd1JRtEqzn999kiC6qv16xmoAu8yWT
 k5HvLhGFlSUPXf2l/eIXxn3ilGi1hDiNHRQhjqlCpCufK+VbsuU1O+G8cs/s8GuTy4kiCy8DhsP
 2bXMMHkCDTiSXvDNeqKWJASFi1400UnHsVfeuTY4VypywZVOkQVJGDwPACKzMzbuN9sbuB08=
X-Gm-Gg: AYBFou02Cec+rxLkidvFOF3yyMInhSlcmgR9mwwM9w8L5zVRLYsahiiPdPSwqPMjhyG
 +iFJH8hnjYOkLloYMZ2MzKp/MgcznY+PogLjsLXFrQPPe6kmVxHr2AjdMzO96CIO3DhR/m/b6Dx
 O+/87O2LXNJYl8/bgmeXn5PNSzPB7zVNh8uHCyo+/p+eDGLROYuPkrIbeqFJiSjZodemD/ij5Ec
 iHnQVOvV3G9CJjq8An2XQin1amZ8K/DbLHyOscmr+GJhmW52sGbfUN2hfYzqtHn2M7VMWvBEpbs
 nMUqGwJf6KuNY/fzAR37KFV7XS3dvk9XVq2fj64Ugutd2kegikFjRtZhFRUgQ/G7UZ6UxL7rpN5
 Re6kMhFA7PsK2u9NtOVSwJXkKvZoJ1WXD1eN/OyBW6o7+
X-Received: by 2002:a05:620a:4801:b0:93e:5677:317b with SMTP id
 af79cd13be357-93f17f4a93bmr1560419985a.25.1792356668047; 
 Sun, 18 Oct 2026 13:51:08 -0700 (PDT)
X-Received: by 2002:a05:620a:4801:b0:93e:5677:317b with SMTP id
 af79cd13be357-93f17f4a93bmr1560415685a.25.1792356667534; 
 Sun, 18 Oct 2026 13:51:07 -0700 (PDT)
Received: from trex (5.red-79-144-193.dynamicip.rima-tde.net. [79.144.193.5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d756ce69sm148645925e9.4.2026.10.18.13.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 13:51:06 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, trini@konsulko.com,
 neil.armstrong@linaro.org, ilias.apalodimas@linaro.org,
 jens.wiklander@oss.qualcomm.com, sumit.garg@oss.qualcomm.com,
 dlechner@baylibre.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 tanmay.kathpalia@altera.com, bhupesh.linux@gmail.com, n-francis@ti.com,
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com,
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org
Cc: stanleyjhu@google.com, Macpaul.Lin@mediatek.com,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 1/6] ufs: decode string descriptors as UTF-16 big-endian
Date: Sun, 18 Oct 2026 22:50:51 +0200
Message-ID: <20261018205101.2362593-2-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018205101.2362593-1-jorge.ramirez@oss.qualcomm.com>
References: <20261018205101.2362593-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA4MyBTYWx0ZWRfX5ff8OgUerFKl
 7/TfxhFLdtwNhYN6Vk1hYCWLe5Dtlo7rBDxUW6bdEr1DRYTdllOZw/ZPqzIJK1QzXeyvVB18BGw
 tzYIRVPfdoYjclixZ+UaYRqttXbjCM4=
X-Proofpoint-GUID: 7Px-8P8FDJ9tsF79Y29PaocDHRVONoX1
X-Proofpoint-ORIG-GUID: 7Px-8P8FDJ9tsF79Y29PaocDHRVONoX1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA4MyBTYWx0ZWRfX2V5RdNE8ide3
 QCysrrLLG/hL14LhYQ0A91WOWafT5YhnzV5sh8WmaPjOkjGIdIm9yM04AUxatwkxTHdbxJ6b6Qc
 6obv+I2Jnkq1BndeS94HgQKTLkSKY1EkJNPX158x54uYzTo4s2R490MHznzABn9IhL8CkQ0FK6v
 znDBz4gFdbMQ9T6rj40F7ZcI4xh1WjOxykVR5K9A09XAnrDNXKKrMzz0IZoqQ2YIHjLIZpYWWZp
 QeWGyBAQz2FG9Mn2MR9uMrb1q3cmTv9fiqIPjenyvXaKKVXQNUM9CIJ/gMJa1D11EkNze7C3miY
 STvge1qjvlqantoZPNPjt1mgV9ur8X0O9qlpCYBZHVXmw8CkxyktWRAOUrfRnKtiepCyudQzoCR
 QqSopZreaT8ZY3hot28wm+joozD3HQjyTnSWBwozSPtZOxrSgyt0a40vU3Qya8EXdS0WOqvbMTR
 w4aUUKNnF/IoGDoYlqg==
X-Authority-Analysis: v=2.4 cv=PMeaavqC c=1 sm=1 tr=0 ts=6ad5313d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nno+U714v6U58lXnMUU6PQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=aGQo9Yp8QdT963r2dccA:9 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180083
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

UFS string descriptors are UTF-16 big-endian (JESD220), but
ufshcd_read_string_desc() decoded them as host-endian and so left
dev_desc->model blank.

Give utf16_to_utf8() the source byte order and decode UFS descriptors as
big-endian, matching the kernel's utf16s_to_utf8s(). The EFI file-path
callers consume little-endian UEFI strings and are marked accordingly.

Fixes: 067c1b033282 ("ufs: Call ufs_scsi_bind() from uclass .post_bind")
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs-uclass.c  |  7 ++++---
 include/charset.h         | 17 ++++++++++++++++-
 lib/charset.c             | 15 ++++++++++++++-
 lib/efi_loader/efi_file.c |  4 ++--
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 6ef01f8e4aa..21aed9f97bd 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1767,11 +1767,12 @@ static int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
 		}
 
 		/*
-		 * the descriptor contains string in UTF16 format
-		 * we need to convert to utf-8 so it can be displayed
+		 * the descriptor contains a big-endian UTF-16 string, convert
+		 * it to utf-8 so it can be displayed
 		 */
 		utf16_to_utf8(buff_ascii,
-			      (uint16_t *)&buf[QUERY_DESC_HDR_SIZE], ascii_len);
+			      (uint16_t *)&buf[QUERY_DESC_HDR_SIZE], ascii_len,
+			      UTF16_BIG_ENDIAN);
 
 		/* replace non-printable or non-ASCII characters with spaces */
 		for (i = 0; i < ascii_len; i++)
diff --git a/include/charset.h b/include/charset.h
index 348bad5883a..79d0ae1ef49 100644
--- a/include/charset.h
+++ b/include/charset.h
@@ -13,6 +13,19 @@
 
 #define MAX_UTF8_PER_UTF16 3
 
+/**
+ * enum utf16_endian - byte order of a UTF-16 string
+ *
+ * @UTF16_HOST_ENDIAN:	code units are in host byte order
+ * @UTF16_LITTLE_ENDIAN:	code units are little-endian
+ * @UTF16_BIG_ENDIAN:	code units are big-endian
+ */
+enum utf16_endian {
+	UTF16_HOST_ENDIAN,
+	UTF16_LITTLE_ENDIAN,
+	UTF16_BIG_ENDIAN,
+};
+
 /*
  * codepage_437 - Unicode to codepage 437 translation table
  */
@@ -299,9 +312,11 @@ size_t u16_strlcat(u16 *dest, const u16 *src, size_t count);
  * @dest:	the destination buffer to write the utf8 characters
  * @src:	the source utf16 string
  * @size:	the number of utf16 characters to convert
+ * @endian:	byte order of the code units in 'src'
  * Return:	the pointer to the first unwritten byte in 'dest'
  */
-uint8_t *utf16_to_utf8(uint8_t *dest, const uint16_t *src, size_t size);
+u8 *utf16_to_utf8(u8 *dest, const u16 *src, size_t size,
+		  enum utf16_endian endian);
 
 /**
  * utf_to_cp() - translate Unicode code point to 8bit codepage
diff --git a/lib/charset.c b/lib/charset.c
index 182c92a50c4..8ccac4048c0 100644
--- a/lib/charset.c
+++ b/lib/charset.c
@@ -5,6 +5,7 @@
  *  Copyright (c) 2017 Rob Clark
  */
 
+#include <asm/byteorder.h>
 #include <charset.h>
 #include <capitalization.h>
 #include <cp437.h>
@@ -458,13 +459,25 @@ size_t u16_strlcat(u16 *dest, const u16 *src, size_t count)
 }
 
 /* Convert UTF-16 to UTF-8.  */
-uint8_t *utf16_to_utf8(uint8_t *dest, const uint16_t *src, size_t size)
+u8 *utf16_to_utf8(u8 *dest, const u16 *src, size_t size,
+		  enum utf16_endian endian)
 {
 	uint32_t code_high = 0;
 
 	while (size--) {
 		uint32_t code = *src++;
 
+		switch (endian) {
+		case UTF16_LITTLE_ENDIAN:
+			code = le16_to_cpu(code);
+			break;
+		case UTF16_BIG_ENDIAN:
+			code = be16_to_cpu(code);
+			break;
+		case UTF16_HOST_ENDIAN:
+			break;
+		}
+
 		if (code_high) {
 			if (code >= 0xDC00 && code <= 0xDFFF) {
 				/* Surrogate pair.  */
diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
index 19b43c4a625..7dee57d594a 100644
--- a/lib/efi_loader/efi_file.c
+++ b/lib/efi_loader/efi_file.c
@@ -184,7 +184,7 @@ static struct efi_file_handle *file_open(struct file_system *fs,
 	int flen = 0;
 
 	if (file_name) {
-		utf16_to_utf8((u8 *)f0, file_name, 1);
+		utf16_to_utf8((u8 *)f0, file_name, 1, UTF16_LITTLE_ENDIAN);
 		flen = u16_strlen(file_name);
 	}
 
@@ -216,7 +216,7 @@ static struct efi_file_handle *file_open(struct file_system *fs,
 			*p++ = '/';
 		}
 
-		utf16_to_utf8((u8 *)p, file_name, flen);
+		utf16_to_utf8((u8 *)p, file_name, flen, UTF16_LITTLE_ENDIAN);
 
 		if (sanitize_path(fh->path))
 			goto error;

base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
-- 
2.54.0

