Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4CDCC6B19
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 17:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC501605AC;
	Tue, 13 Oct 2026 17:48:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gkxmwL5daNYE; Tue, 13 Oct 2026 17:48:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0EDA7605E5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791913690;
	b=Epj4L7hmcd0qMPD7EX5qwcCQfbz8fQaLJUcP0+ODyECFMdicu+TMWZwiSoC3nVO/MBpn
	 nvvmrhEt0FN38S20xsILv9/DGI7Wmc8gg2RvNLR+A/q8m1La5WdJ79dgaePpd9MloTAeT
	 CJFenM5CT19Ny2PPvP7Unpc7IXSjASahCybCJq7EAXz9MgSQNjsndItY8F6hMo4p4Pjuk
	 eZocROWjMOoOrOMAMOjyLKljWinsRqWdGM2vttN+FLPU4IuqknqlSggVjpsGT+J5OwD9I
	 dGK1kCt+K5Z5AC2LQ0Nu3p/3bcA1XwMzPQLHynn1nlvI9OhcIk2/9QiapH8143bhlFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791913690;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:
	 Date:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YAduux5lKZwToKQ21kReyix464CI308RvyZrk46YzgE=;
	b=DZ13GXi1/mJ00J9ALnZWYsYOLesr+jLv2rxEKt/ZlYKffWxG3o56UUJA3uQmdoIUgL6u
	 z1M+dGRRnm52c4x5JdghomeQpJAgHprtBeHp9lce0reZTghv6fT06CSJRsNHWKJmwxOpS
	 oCeti6VMChEawmyhgjHujLaJ4vzesWFYtgwRPIxwWBGnXzuvpOtvilpUGCfIXJbdqwjzH
	 A9ZZJnjB0rQBoNr1TMxvFgLERi93Vli6fD0JERzfCjFu2nbh47u1vjJPbBNDxVjl4s6Se
	 0hIxJVseAEFOEUYK2SbULnaogdGmjJRCxBq0xndxk9Ywr1z8Ibhm2x28t6/BI+phHeg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791913690;
	bh=YAduux5lKZwToKQ21kReyix464CI308RvyZrk46YzgE=;
	h=From:Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=slNigh7XE+QjUP5S7yPEeimUVos2AGAH7X9K83EKFNooUKrmHMDguFape3be65XdH
	 7yrL945tHRxDx/a2yx6oIM+76HbdXeQivgwTWSUIkLh5/jJ0AJgwbdMnwpSH8TlFQT
	 zbIESobgqx12DOWxyjdqsiihTwfFMqz0RG80cdJgBn+/kId3TAJoeSHd8zLu6xrewK
	 ngI2RlZuboxIYdhtAM4GZ/qHfhGDKw9lCHYDFuH8UsirsdRO5I/8S3M4Zgx1i/4ANL
	 ZU1+vh838UGFpCwhYcMkd4Bjc+ODQlutL5Gp2nwkucz4Bzgaw4t/foq1X8b76KhMGO
	 uqrgKV/ZkSsjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EDA7605E5;
	Tue, 13 Oct 2026 17:48:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EE8612AE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 17:48:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC0CC402D9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 17:48:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nbuKZJjy5Tmy for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 17:48:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B07194002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791913688;
 b=Dxa0XJfk7HLqtge7axTjso+1Fin4cAglXv4HlE+jMYEHPKRawD+0WnajdbNSmgyPcUl7
 TCxRSTFYiSfUuiZXd/tBTPwp/sLcKkMKUeajNiO8c0Pj0Z9ugCmRWvcBlsYDmVu6MvwQD
 rngsEKL9VrSUrPyrco36UpfJ3pX67iqUcmCH44ZaBRaUNBYVdZb+wQ0mP+zmFDvIHC3zB
 6vDRiinO5pubvkcDaUPDI35RPkmzBGQH/N6TLu4n3rl7C7dByz4TrgcuGq/3G03e7vvz/
 A6IgzOZb4uraWKTwLRiSWA6In0mswZ4p8449R76F0+LUIxNsTeL+Dzn76J02LaFO5IQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791913688;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=YAduux5lKZwToKQ21kReyix464CI308RvyZrk46YzgE=;
 b=qAN4aPieW7k1JpWzC0EBRRj1ymapLABTeUXYgkYOWuw7Y0WCLP5yJ7C/GnGkDY4wCis0
 W2HSUa89ldK9n5bYwRN656+4oENQAwrlhuL4TmKwL83AhlWGQcZcQU8wHuGe+oMiF6hTA
 tcbd4O8Ohw8RQX1dBfk/xZtt8O4VIfY5qlB0eMap320Gjiq8JiXej0lbm0G6IXbqqvlFP
 /7YXnJ9QYjGIs3ZXgyGpVALETw4+VPdww7UEV0HWBRgT6wVJmoYzJz9+XogcjuJAAAKDV
 bvpQ7mi10pT6kqYEbGOalYIpUltc8byM9I50pU3KzF8M99NoY6733fbkUq/JXR6FxJA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=mpvjralD; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iG7gWRKT; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=mpvjralD; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iG7gWRKT
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B07194002B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 17:48:07 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DE3ZSe443059
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 17:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=YAduux5lKZwToKQ21kReyix4
 64CI308RvyZrk46YzgE=; b=mpvjralDYn74TPRuIR4nZyNW8dqV3+7C9cBuqWsm
 1mnLF+nVZ0mjoEJEruhWRGLq2lezyvewj4H/uve6Bhw6Xl/Fwb02vLv01Rictm+Z
 tN8YfyqYTV4fZwQxaxF3id2wFKhVXt3nU1yOTvBkHVshf+g0EMM0DJV/kYjI30o0
 FmOk3BMp5QKUOBTpJsnpJ1kp+W0eLEBGMHOAyGXl+PdJdPLIG9cSSAnaw12sRt6D
 LeGJr+6uU5rWKtbF/h+0cGCQh+Pv7LD7P9ZUtnGjKmOJAwuCdzj9DHoTJjt176m/
 HKqmyKx1QiuDkXfYf5j88V4KoIQysDBX9PbnqM75/4D8Tw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9n71hcbu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 17:48:06 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93dea1b6c89so622653985a.2
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791913685; x=1792518485;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YAduux5lKZwToKQ21kReyix464CI308RvyZrk46YzgE=;
 b=iG7gWRKTQ2f/yWY9kSkPE0Rj7logWPH9Ic2oI0qtTLEnFCnUZE3MAfk49on7xdoBmq
 xnhe/MKbs+vyidxzEWP+Du4XmsLydQYOXfA8a1+r1486nm3AJPObK9vuNOIRN69VVuof
 9LMDSMDPRPn/A89sFoq5KRsMt0DheZjVCgMWy3wAGAmG3XhbV7KZ/yW/PhkgkQhwIx8j
 /NMdQEP0WBV1kjE0hX7Pn4tutykPlZue/X8iVqf3xz4YG0KI37LXJVlWnY/4OBz+IKyG
 ORpTlgobZpFrhuBHotm2rnk4M4JR2YiKmQYo8fhXCDoYcImGktojW96xIaDKTF575glg
 +Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791913685; x=1792518485;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YAduux5lKZwToKQ21kReyix464CI308RvyZrk46YzgE=;
 b=MxTxNhEcdnp7K0n7Y3lxXvkkbgq6HrXLIp7IA9Fmx9PHPjpOVR5vLY5RCsOdf+udbQ
 MY1Vz2kGJor8bziaCSUkOsuLylgn4DCnq3qJKIMqHQn96TyAiP56Mk5BX0Ldv2zLDBzZ
 M8U+MYmHBzW8M/8uG/xsh2yC1sDpkbr0LtE1mzXWOm5cxRGYxsUehc0MA1Cg4S+QUot2
 yW5SJPoQaTSkXHKq+ylShWJon202V7VG6hgFcAh3NViKejSGWyXB18DKkuLLVKZ/JR6O
 HbBVtu+wT5TZAagCPfPG7z1LWj1CV2EKXGx1sN64G/dDLF/1dJUWaZdDfZjxvEdJH1dy
 SLHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBze7XxgYhlAHVCkm7O8jvsFb+f0QNc2IFX1UrOs8NSZqYRnYPRiOeMma4rMLwbQ5ZBZbhsK+sQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYISKet5Or7uDTZW6VOnEswkYzzZaYGwvTRPEnRI6lx/JlsTXxTA
 ED6KI69M9d3vTLSRsCEVIMs4bVN0llpHsTJIxWpzymg+TlCZ2/8puR3JV21bwK7P7VmzeRunifB
 IpUVkkP4jjvmaE4RS1EwhVFlggbqf7YMr8atbh8w8SFPPqMB2rsi0K2hF2as+PoypYNxc4Uw=
X-Gm-Gg: AYBFou29MuGUm0ESttPbQBodfUjbcvTe/Eis/QUDvnQP+6NCZFZtJ6G57fEaBOA0/HW
 Pmxv1RXr5OBhp3NIazxPrfItvDh8hZfGmXQJMb54+YSaDd0R9vvbkI0bp04CT4cz1foWB2U2TPY
 2AIUz88QJpXaEmspStJvrYnYb71obvT3YDeZhPTatMBkDjY80hT1o/3n6XaocckGNq2IOpW6ARH
 7mQ/4ABGFaSIrl6Vat6sQ3jWAWTG765ARbDlHLQBoC3lcHbItLt8nSCc8OJ2qny6FE92L4QeOtc
 bfspnGpVs81FbnXHHEt1iCHoXF7ehLmn68/kFm0pnEKev57ikFa73ek2zJlkP/hGGBlZzvbVyjO
 vNrlFb2i5ZuW/OKZZP/B+D2CDH13f
X-Received: by 2002:a05:620a:2719:b0:93e:c12c:43ff with SMTP id
 af79cd13be357-93ec12c492amr2025697685a.76.1791913685341; 
 Tue, 13 Oct 2026 10:48:05 -0700 (PDT)
X-Received: by 2002:a05:620a:2719:b0:93e:c12c:43ff with SMTP id
 af79cd13be357-93ec12c492amr2025692685a.76.1791913684781; 
 Tue, 13 Oct 2026 10:48:04 -0700 (PDT)
Received: from trux (5.red-79-144-193.dynamicip.rima-tde.net. [79.144.193.5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf31b83sm389999485e9.12.2026.10.13.10.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 10:48:04 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Tue, 13 Oct 2026 19:48:02 +0200
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 dlechner@baylibre.com, trini@konsulko.com, jens.wiklander@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com,
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@oss.qualcomm.com, jens.wiklander@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v5 2/6] ufs: surface sense data from ufs_scsi_exec()
Message-ID: <as5u0mYRzhi63SoR@trux>
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
 <20260918200641.2286077-3-jorge.ramirez@oss.qualcomm.com>
 <CAC_iWj+MuqZ1LnPCD0SmK5ATgegWZVix3Uj99NwcqkRsWSVoDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWj+MuqZ1LnPCD0SmK5ATgegWZVix3Uj99NwcqkRsWSVoDg@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=FuqQbGrq c=1 sm=1 tr=0 ts=6ace6ed6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nno+U714v6U58lXnMUU6PQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KxHcFGIAIZmXjwKRIakA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 5vROGBXj5wjtOwcOkKk2qQKRHlZnJRTP
X-Proofpoint-ORIG-GUID: 5vROGBXj5wjtOwcOkKk2qQKRHlZnJRTP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3MCBTYWx0ZWRfXxexcUoaMqUcO
 2m1q/A9alPio9r7ElJCIplVv9CNRpAuhBYBwBm6NN7ZBenLGyjzA5HbfxvHfQR3yK7CIWM4LyqP
 +max1uDQPsRVeF1XZeOZcT1/6tPPnVgmSUrXVflKueUygyvoLEPvDFu5rsNQV29z+J7T1FxJsdE
 ArH2Vr1Et9EZDh6iJyhJKYRmGUjumaFEsqsklwyzJNlvdDRjNuADR3ZlRibpt22I4Xkux2y0YRM
 eMVrEBEZsJn9/WsS8nEnP0cBlRmBQbrf4wQay+j1tfbLYFSovl+bAMXIcXxAuc9z3HFoMqt5vfm
 DzANn0/xvhpTAHHUuorTEZNxdb09dsdYdHK7MWrgoBKz17Wg8t53hFYcjZSPGpP0uyH0NwKtec9
 fq+/BZkdTUri7FVRJUd24XPPHEbZHoGfKHGrl6l0uN8k3YBuIODRZd1I2FBsbtg/ZIwfgTWhii2
 wzjXCjf5m5tPRd4jQqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3MCBTYWx0ZWRfXwf03R2F1cYpa
 82wVTOFnCyyLsa11ynnwWHQaSKdHZFADcxKhSYo+UOJOTJQH9Oy4BFCsalKEeqbtBLDQfMl8x9v
 77rmEdkwnMNkCB/o9DdxfuOVHZ0DYlk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130070
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

On 02/10/26 14:16:54, Ilias Apalodimas wrote:
> Any chance we can get an ACK from UFS maintainers?
>
> Thanks
> /Ilias


Ilias is it possible that the maintainers have silently quit?
