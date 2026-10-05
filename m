Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD853CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3C7E60623;
	Mon,  5 Oct 2026 07:01:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OUGvWC3OGpbq; Mon,  5 Oct 2026 07:01:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D71186063A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791183675;
	b=XR2VApxTE65g6eEQBRMO3TjvO/L8spk5Ft4LXyKzOV4ueLwLuPxXzv+Lg16PRytTbi+5
	 GorqKok548Ucz2r6z7jcXv34vp7LFoc7ibcQ1fcU8SeWq2Qy0tMTidpT4xiDbFHQ8iMqN
	 sicHezOXu8GkGTGLvmYx1fg86FevcGgp7s1GUPcGsbYgnRxvoTYhTZ8hJKtgooq2vWm9H
	 vAQUe/bk/mN14fNyLFMZjRdUSgR8GfuCo5ui2wKyehRMhE8MwFuJ7A0qQj9dTmmyrJRAn
	 MH/I3rOyM2jRRyLnb90G0qOR58i9QYpbnyjQM0vNXzRveAOxejNSwtj6q0TlDXhH4ow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791183675;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pZJRS6XDMtAvRF/EukerNef0fSgcbR+HdXlJ4+U9nDo=;
	b=XZ45dVILWL3seNfzx/naBCqgromjEeiU7l5ZLmwRZtp557v73tOiGWK/QtMA/xjJKA+h
	 +BDce58ePpKs3M8FXkkUUxzPeK/ytHdEYL7vmJpIig9GCEGSafqz098H4QhbFYD5VWuxG
	 DjjsiNOC+awFSlhkWY/n5phaf7xddJjZs3rhvF/MCivD9DeuTCu9MG7WaMr8bpvDacObQ
	 80ZjfcWDZerlT+MktLNKISx7sKXiKtrylIloDSfQFacV3UEZuRcit4lfEU33wL5K7k7m3
	 Mz9oD2FHd1fc/2rupqbJFUKiS5kdwWa3s3FlVQ+6D8jvT2VWcNoAvQCzgWGdk6fVb9A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791183675;
	bh=pZJRS6XDMtAvRF/EukerNef0fSgcbR+HdXlJ4+U9nDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v6p0uJb7UQkjVvDBGOFsHGyVExeT0QBr3vKhpZnhDXGaOPfet1lj/E1AXPSaqSxmW
	 +l/A+XuDIGXDL9H+KwEUdjzUfQQc8qTN1a+RwC02/0NdhLDAnynD9Bi3UjbYmSNAws
	 HKTYArhnkQzfG7jHmbp7chsdUurN7rRlZmK7q84npfPGXnCuUzcDd47gBeC3f/x95T
	 LeukJLS+Wn9pQkLgqgAHDRzRDWZo5WT742c95ZEPlfuBeWJDy0CV9nhlFeqhaCp8NW
	 uUQBOLjXubOYVMw5DM+Nmh6G1uiajkGjC8bvzgbK1NitkVXmvykQjbre2X6tkkNIPL
	 +j2DkyeKzVJhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D71186063A;
	Mon,  5 Oct 2026 07:01:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6878F75
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E831405A7
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:00:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y6FsIzNMy567 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:00:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A57284055A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183622;
 b=IJlBj76KfbRTVy0jPRBLLw3UG59+hbGh2zuMTznHQGz78g2skAcwy7nz8pjNDZLnOIqm
 PZ62zutIAZNUpxRJiWzj2gJDVzZSKzMQdbtVuM4r+Pj/2wF9JAkNoJzm75VgxBNYFUoRv
 SgCctXULkzXE8bCxUoj3NOfjEIRT+Y0f4lJhY3Y+pM9S/Dme6numqbpOwJ+brVcZmQD/o
 MVkeKWuYQywWzGK6KUfEDXUU3W3B0VNE9gxRt6Tj3PjphZLmxP4OZh+b4baDdb9SLHfXd
 USAzsr3qHgX3ok1T9UD+zoLyh5JoxQwAM3XGV/GUbJ4Y8UpOjZFmtshOAx2/RwT68/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183622;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=pZJRS6XDMtAvRF/EukerNef0fSgcbR+HdXlJ4+U9nDo=;
 b=h1VS3Va521D7aX2xNJxrQ6lRgNAOsSAeJeY1oszQyyvQx9ybLPQSrLXao4cGzpkpE4/m
 IbP+kaoAhQXRUhgk+zzjygJ3uKYPaBvFeIyvcmWKOP865b3vQqr0swUyHGoLLR7kET25R
 TGWsM3U4U/KPJ8HbgMALRoVVW0owoudk4JCYr9hLFa/M5gq/hvPjc6+HfidFypgZliXaI
 7WnBFv+opxUa/DiJ+Ku+ImokCIo6Qd9hkKv2EHYcVZUgQQkKheEIVkAH0enkja0VECtJT
 Q4/acRlAVbvR6TIurN4dtMS2dT/JRDrXUtTQ5976V0dSYBdt+IPiDqxW1b2okYZwmjg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ot1lBO3B; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZjJtiQ8B; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ot1lBO3B; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZjJtiQ8B
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A57284055A
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:00:22 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695103kl3242309
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pZJRS6XDMtAvRF/EukerNef0fSgcbR+HdXlJ4+U9nDo=; b=ot1lBO3BIBGp3mjt
 83H/cW7sVRWRSirMmh6PbWum4aYHlQjjOEZmeE6H611B33BEKTAAmfjyoiGRmWYb
 rSTWloBcD8O6HDjNe2YDMPM4RwIQ2fes36bHGXPgzJ985pRZCKBNDg/xfFSQxWMS
 awohjveM3Rj5BCLCT5A0bNhg1W3JukjLG+ZbZ/MLzPFpXEEnrmNZTfMST0xtw6nc
 J74cPR5cwN3ujxnUBXnCBtyBnbjAQhMr2XRst5UVhjWK2qThJ0PiZwL1R0P//tG1
 7xRENcXc1adOjEWYoeEWPM0lXgsSn9kts1kWhDIYhkEcmrsEKYz4BVoQlPbtGuOq
 UmT19g==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2tvevnv2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:00:21 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-14a62326b51so980716c88.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183621; x=1791788421;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pZJRS6XDMtAvRF/EukerNef0fSgcbR+HdXlJ4+U9nDo=;
 b=ZjJtiQ8BztJDS/S7JsXB3eazHSsSPzQmNvP+m13ycGN+4nxwPTjrnU1vdD6A1Px1xS
 82t5lOmuBNtwPn++Ni+SXPb+jpF6t0+K1A76ghZ5aDR3XgD+zlHG52JiP8AC+Ogfb+Oh
 OjnNvqsHxrM5lxFzN0YU7n8utClZdeuOrWnChG3RQDvtL2YQHjcxAlqp/loNhhww/Fw+
 FOKJHl/DifX5EOZBbCNqneshzu0HOr7+0+64tOpXQQyFKXxnn8lsy3B9KcIvy88scLZ5
 DGJclSYtsKQeBawUXUrm9e7HwELktKeX1AzOpK2iSodh7muXysfKVbSXvxw3mkLwMzdN
 TMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183621; x=1791788421;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pZJRS6XDMtAvRF/EukerNef0fSgcbR+HdXlJ4+U9nDo=;
 b=mBvjRgnhH/vasekG7pUtRKpOZfPDiaot6ASfHCL4rVOwyuBnHE3RewdYOQ1RufDFkI
 PRmWu0FN5RoXh5lW5bRJ/sX+73GARuVOrt8MTSlUwhw3v++a7OnR1uR/Ar8q+auCPq9H
 XvPIDULGlsy13bWfcwrZosNyrlVKkvSUcyuhFsAaeKoxend1mUNI9ba45MPDGnzJa00/
 XRffSyMGLREbXOCDRl3Kr3l8jrWdWgabt9EgNXIFPeAG9lzqp26q2KngqkgG1ubl4WTI
 TLjxkbSA9QNXygBkxBT5r0iAa9JwHhtfHcAP/XkRiTUQDc9N3vBu2oTozZcQJ1oXDyBB
 thsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByMJQx9MDvfxoEeg18DwtCeIm4ZJUof62ie5XBf9KvC816qKZTk+NAnnCIgkabMSJcvsJDuxMQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kueDF8O5BRR8rMV04aujIGlCcf5GEFHIk7xD5B1vWikUBQKDo1
 kZZrlaLZgazCtpzjno1GZuQ4C9eh3e6zMXVBiSV2JB/YCCaDCPRoVttoE7Qhn30PPlzV4D9XQgB
 PFe3ulq+cwko5eW67TXe6B4pwg9w0zaL8BKR5o8Mb1jP7bBX/eTCTmblFcYuMTLv+bSBtXGMqxA
 LHTJw=
X-Gm-Gg: AYBFou060LSgy8vxNrdR8OYrdqt7oOjeRu9YuelTqOoX7oz49KkKexvN2A+Yc2rjfvY
 /uyqh535Wlj3z+ruQO8ZALhil5E0fsEI1Cniabdp5aWP4zPlzepDP8pGEeIHLY69C77EI6s51FU
 DtKOq3V4MhzJpE0B/5KK3pfzmNFJkXTInA1oOCKX7FB3yx7hbaa9Sl+iUq7lKsafLEcWKOjuQST
 hLbSASBRGT13Py1XKPw9tbD6cIv/ECfLpy0eEUycTLoijtBL7meWmpL6LYXTKlExNcwNqRUm9/H
 /pgKXoWcR4vZo72aQXUNBxrE8hUvi0RXjkAbNd7mgfCleO6MVQoRzshNCP1jDQ5lFn/xDza/kAm
 Mm6lsmEkzzxB4010Xrz9hxPo2uT224i5mfQFeD7+CQ/5hkDjD1gTeBfUciQ+Smg145lUPXLdS83
 q+3v9eD/oSH60u+d7zbnvuJHKtqXZh
X-Received: by 2002:a05:7022:b88a:b0:14c:1f57:3ea9 with SMTP id
 a92af1059eb24-14f5bef5190mr11418750c88.26.1791183620286; 
 Mon, 05 Oct 2026 00:00:20 -0700 (PDT)
X-Received: by 2002:a05:7022:b88a:b0:14c:1f57:3ea9 with SMTP id
 a92af1059eb24-14f5bef5190mr11418659c88.26.1791183618872; 
 Mon, 05 Oct 2026 00:00:18 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fca985c6sm27963498c88.10.2026.10.05.00.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:00:18 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:29:57 +0530
Subject: [PATCH RESEND v3 4/4] tools: qcom: mkmbn: Add support to create
 multi-elf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-ipq5210-v3-4-e0ec14fb5796@oss.qualcomm.com>
References: <20261005-ipq5210-v3-0-e0ec14fb5796@oss.qualcomm.com>
In-Reply-To: <20261005-ipq5210-v3-0-e0ec14fb5796@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: podrOh6u9hJ8EaUKQrriX6ssZXayZR_W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfXxdNF5gQJPrHh
 aLzZWapyIjBWNkzDkRaowVP6PbkrxaqRp4tiKNvypK14kspUtjLuSVcoF2mxkoIEy/Ivvgg5OLk
 xNHznn83UCYi2nWFIXXhW9gG3fA0X6A=
X-Authority-Analysis: v=2.4 cv=YoGa1IYX c=1 sm=1 tr=0 ts=6ac34b05 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=S3gQTLpqa8hfpVGigeQA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX6BsQyP1GPNYv
 HIeyGoiiuasg5rcNYVThrv13jv87H6x4lkSCb6YNfxD77Iz/G45YaS04LXKJdxVhOSucEY8TYMJ
 q4RL8nbJY+zR3Og8b0TaAam8foJEsWsseWt2Wg+nG9jc8jstaKB2iYeiFo7xCCDEghPUFWHalFB
 WLfOukP6wEPHyyX+JP+f0YVzAmxmOp3mcKAjklnEKnsXZy1RXe2cd08plt9LbeHbGHeWCi6kN29
 MlaOq+bKY55XYUiV1sVwzIUwdmoPOv2nUMnDVsNMD9/84UeZRam4YkrrtYlyLPqmR3PaDTxdOLI
 AAXWMMDhDdV2LxlyY/H3kI5fLAcGsPtjGBWeW4ywhWcS4kH3JqamKr9QMRTqjVfMm8jnRdaai30
 EUMlB9wlIQ3dH2sK3ZMu4V3S8YCg4GAJAhAv5aFiQa+GxrjlvdRVaO7TKCN/QnZVvgyQLVP4jKX
 0VpbqGN9axwacdRnu7w==
X-Proofpoint-GUID: podrOh6u9hJ8EaUKQrriX6ssZXayZR_W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050027
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

Modify the 'bin' argument to take either a single file to convert to MBN, or a
list of files to be combined to create a multi-elf expected by the boot rom.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 tools/qcom/mkmbn/mkmbn.py | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index da4d45b600a..8af268a2d8a 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -110,14 +110,32 @@ parser.add_argument(
     "-v", dest="verbose", action="store_true", default=False, help="Verbose"
 )
 parser.add_argument(
-    "bin", type=argparse.FileType("rb"), help="Binary to embed (e.g. u-boot.bin)"
+    "bin", nargs = '+', type=argparse.FileType("rb"),
+    help="One or more binaries to embed (e.g. u-boot.bin) or create multi-elf"
 )
 args = parser.parse_args()
 verbose = args.verbose
 
+if (len(args.bin) > 1):		# Create multi-elf
+    try:
+        with open(args.output, "wb") as f:
+            for path in args.bin:
+                with open(path, 'rb') as tmp:
+                    f.write(tmp.read())
+    except Exception as e:
+        print(f"Error: {e}")
+        sys.exit(1)
+
+    sys.exit(0)
+
 elf = Elf()
 
-data: bytes = args.bin.read()
+if args.bin:
+    data: bytes = args.bin[0].read()
+else:
+    print(f"Specify the binary to convert to MBN")
+    sys.exit(1)
+
 
 # dtb is at the end, so find the last match
 dtb_off = 0

-- 
2.34.1

