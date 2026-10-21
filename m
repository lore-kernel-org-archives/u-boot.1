Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0970F606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WoqKQ7t4;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o3EMFUCm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UhUzo+X4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA53B408CC;
	Wed, 21 Oct 2026 16:05:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hibPMu1MkleH; Wed, 21 Oct 2026 16:05:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8B18D4089C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792598738;
	b=nJxed2s9fB1Wz/IPsGBlVbPSzvJYVgPOqp+g1SAAK4RJ7BTF5x300L0fcC2MdsodFqdX
	 ltmm1aiwn5QokEnXmiqBFjJnPEyA7eiMnxU8vj0LIAhWj6HJZ6QLw9EoEg0Nw5zlElKKw
	 GWJe45flGKaI87XGenCOqcbBQtruinMI920551Mjv6pj1iOygGVcUOQ9VO80fJrXKJO3z
	 JTKMgSD38yOJ7SA9RQ0U2LYi6UKHr2vrJnazFiGA5GleGwum+0TMI/ROu4ZL+uGj+co9y
	 Qlr1uEL0NLn7NtOVFoLkPppBDRQhzOG7oIAsnNj+TJjAc2MMWj0lkRsFQnpWbNEnisg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792598738;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+QeKP00JVqtm8UqqbwwSBdLyuRuHSypcnxWqjoyvTdw=;
	b=HQFUQqZdvqIXbX6l17TEeraXiCTHZie1/PWwM/D+u2k0+mFebF0mQvMZndSuHn01BSlN
	 09XedX2RE5aZJfqbupBFMFOI3sNnoWQk4fFoSi35bTq6mhXULJAlPz6c/FHLqsK4aFuPu
	 60/YtgdyXiRMTcB6QBInuVluGnLevbbhL30yyJ0IywfVMhqyn6LEdDfIa+QyO8AM8S6Pb
	 RJk1WMm6q+OlSdpDT3wHYVtMJ3RAthQvw8Y0+sd1TQdRkZRhcsbsD8SXDUsXA4D2aZSvL
	 NDWTq3bhI8Hq5mUSa0Sr7Yjg3/w2NPjW/6xpgjKdBrsQ1dluVS0tbXysCR+6+lPQasg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792598738;
	bh=+QeKP00JVqtm8UqqbwwSBdLyuRuHSypcnxWqjoyvTdw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WoqKQ7t4qqQ6TxB0dj2bu3KrLSmRNcBBqmcJwb458Ru+Z8CSCmsqKIpQSCfLszC8V
	 iInZg/OpLnGpXd3zqcvL9H2QeVJWn7yt7ZP5yQh+VKrq2iROS1WPObOtR88B58VKn+
	 D9gHuVnWHD9ZGcTWxArqnHb9VRhnt2d3ZVkF/XH+/VCCTGKJg9yWbWnnLvVsQ9HkvZ
	 8pbA4EqOdQureq7tCK9iIss9jz+PYvCAgxxviMQRpJJ+2cA+jKkekq2gr5ymA5V9Y3
	 SRkbgOuxpfemOMD8GGH55rEc4MDM135eRHv2QC/oSJfEtdxsRBWIW2/OOt8f8I0+z7
	 VOgbUk0dX9Jsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B18D4089C;
	Wed, 21 Oct 2026 16:05:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 13B7D1E17
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D62C80D5E
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q7u0e5p_7Zzl for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:05:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1A248811E0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598736;
 b=euhd3Rl6Gbirej7b/LLU3CqSAVz2N9SxX5fkYS4l8nAHXqZXlKalhwemeQFvzk+NxIUC
 yyjzsO3+UrkFoQmArnxQzyNnHmuzIP9fiUoRCnMZibkPqcrUucUuTDUHLgJBz3+ehpJ0K
 xmBE6VQjOEohj0E/9JUDo4cPa/0PmzzHb/yYpfdQSvs7y5QOYdvMpAkFyP1AnfeTUWWMe
 EYzjTLkTXgucFx0rKJ26Soz/jT3JS85tvXCkSsHg3YFdRgAXy7kCRZlBCXn7rkQQRlyxt
 9o5hQC/8z5r99gTz2Ynm0bEsjz1106Mk4/gU/EJHcbC5O1e8pIaDZRL7QB39gsmuQCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598736;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=+QeKP00JVqtm8UqqbwwSBdLyuRuHSypcnxWqjoyvTdw=;
 b=Ylq5wSSSe039fyFZHpozndLbUR4yi+8ON4UKwCe5x3bgG4/Pgl9W2dEzSY4AZRDuluX1
 /cw784ksNu/KvuDhDoFElLa7NG/OnsKet9bzJHH0jMyVKr3PrEQcd2zM0fnxCW8YzOx+e
 Ag5FdmqNHxZZvqpStPFv2hWTw+7Smsdv/NonVjic28NzltjfcqPFfQE4F9Mp6Twjcvb7i
 R+xkYZAixVUXqnsyjwr4Wxos0/vf0DgqqYUBUMrAi4be4ByQhmabUufsu0h/5ZL0DUOPL
 cslDsUuz3LKO8/4gONloacLsmESqOSSu5Pc/MUkxDf2RjTyrn779NA1k17EjUXenT5A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=o3EMFUCm; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UhUzo+X4; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=o3EMFUCm; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UhUzo+X4
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A248811E0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:35 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFTp2N141155
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+QeKP00JVqt
 m8UqqbwwSBdLyuRuHSypcnxWqjoyvTdw=; b=o3EMFUCmJcJBGKmGzp99cPckx8y
 ioKUVjwDYZCIYhCYKn8QuDM0jkr/tlmR1ladeXdnWUG8SmlAAIgGRi0eEoJYYFKW
 Dhq2+3Cb1jLQT6u2n7jsGzwA7efRhgFsz0i6I6h9uzaSI7+OL9F5qjqsPH9UTTFK
 01wHzIcUh7qNjGHUdanb1Dyj+JBhotjcl+9aPpoe/owjCesc3Hhwf/i0K/ouAgmy
 UQ/AapZUbUrzDawyxnVcVpHwac0aiFCLIZfpA45KakeddQz/ZptS7l1VPtB7thxe
 2A0GmD8erDR9NZ32w/ykPLWxpEzEY9JmWA0iI4cyQjzPqDjuiAmOgA1VcQQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex588rd8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:34 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-18b5ee75447so3367641c88.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792598734; x=1793203534;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+QeKP00JVqtm8UqqbwwSBdLyuRuHSypcnxWqjoyvTdw=;
 b=UhUzo+X4eVDVXFDjK2XjUtjt8+gyMMiApfvRzzNx0cUbap/Nz6Zon/cDfN20CEssNB
 9Ute9tq9Eo+eab0YLyPXM1I0qULPPb7AM/Es6Ih7cYMemizjSjDT15CRyXVjkBS4GvvJ
 kfdxGIffbf+4uUP9X2nNGc8vMvMo420xxIyBZjKsX+mWWxnifzaTy8IU/wkuHV/9+3D9
 OSbG1q3udxPM02w/Ip7JESLb6COaFqxrBnOTFOEc3tjlDUIBwuZ5Ayb6OkXXTZpnZTLR
 9EVWXF6Mi+L9DlHbS1E2i5ehasaQArKpK0pF3KkBJuSnL9Oe4NO3Nhwdu47shtjxmqrZ
 lOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598734; x=1793203534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+QeKP00JVqtm8UqqbwwSBdLyuRuHSypcnxWqjoyvTdw=;
 b=ALrgtTScTLo4TwDSdBsi0lMXEXe1B2ppgexZOnu14jA5ATKcdcOzbUXAm10tyasJ2t
 tBZXBdtpeB6+2X/TAKll7ebE1Yvmw964N74pcBQlxPEVG2TjOAH1ehXIef018PLja6W+
 afBUJPAgyHCeCBlu275yxTpUyukfcpSpv6PWroTHmuJj9AtbzPs5ZLQFdVhTZc0XY49K
 696KYfqTfg+oxlD9vIWz77e3IsOZJM4b4LIlVJpfi8/+G7TnBw3SG9dIfdS8vxO38K4W
 n9kaQ8KXB+q/WHytNomEvyl3AKzNhXf+/JQx2nRB8DI11pfOaD92qcUcAUNxaylUSWRO
 shDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxc/XfGJ0GgPzlyZ7f5UGxpl7jBtHkDETZTQCVaz5+3NuioT0Q0jSqqc/RZjX6RwqrzFlQ/Xao=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIX2K8AMj8oOeNLRKBhkEwmK0Mv7cG0nGCQN9rDt8o42/kIvfu1
 1m4pMOypNVxmyA6D6uU//TJgGztW5hasnr5MYvqitOahEFldGf/vItcSJgbT1SLPNZn1VoVYet+
 V2c8c0OIcrsTCUmLuTWYeYSQrim7fNu7DrnQieDvsA0jwkJrvs2xfbSir76Q134PF/KyYFaw=
X-Gm-Gg: AYBFou3gZM0oOHQomumnngbzAfWvtVJYZanO9XlxmH/klBi1WCWnWeCpIxr6ENiGMrV
 D55VYogzmU2feYAAnArtgOoabjowtEEHXRH71LZkhJV0rVomRtawE8hHr99tCiGC2q4tnHCFYBO
 woFcsvO2KRY+oi91f+422Or0RRrhR+iuqBMntyzC6o/VZAsQc917lbBSME2PyTM83QGbbnfLeGV
 xG6cS35Vk26vJYZ0Ey3yCNLEuvtPjRE8RzysfrWcyQohfj3cRgaXARFlYeAbMYC5oo25ODXO6Qz
 NOqxpnUEQsOyULoOHbbOjMvjpmJfnuVDmyO7iYErGoVRWo4K1loqpucaRdvVFAGOYEiPemoKGI7
 SY/hchzAkdDVcPojWKLpIemGvnKlginvKsibPdmdhzjqSS7HwtLoaPtCYT7kV+k0WqAgRp4LdlO
 03i5O93gxL5Q0vnkDQ7E8=
X-Received: by 2002:a05:7022:6b92:b0:190:d7de:883b with SMTP id
 a92af1059eb24-190d7de8999mr4316718c88.35.1792598731015; 
 Wed, 21 Oct 2026 09:05:31 -0700 (PDT)
X-Received: by 2002:a05:7022:6b92:b0:190:d7de:883b with SMTP id
 a92af1059eb24-190d7de8999mr4316577c88.35.1792598729280; 
 Wed, 21 Oct 2026 09:05:29 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903d3ae06fsm7480185c88.19.2026.10.21.09.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:05:28 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, aswin.murugan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, nathbappai@gmail.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, jbx6244@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 3/8] clk: qcom: add SEGCC driver for nord
Date: Wed, 21 Oct 2026 21:34:43 +0530
Message-Id: <20261021160448.3893858-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
References: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfXxGzPAdGbBmz0
 FimTLQhVuSgmu7eRFx/oF64nO+grKGtZwmf0iy4+DmzV+66sO9/35iddvUISchyRfJX6wHfToEy
 oZW2BHT8+9qvXbsy7fTT2ZYk6btDHoE=
X-Proofpoint-GUID: blC6Dzear_mkDIq0iRdVu7LhHaFAdioR
X-Proofpoint-ORIG-GUID: blC6Dzear_mkDIq0iRdVu7LhHaFAdioR
X-Authority-Analysis: v=2.4 cv=Ku7YSmWN c=1 sm=1 tr=0 ts=6ad8e2ce cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=eG301sXog4t-Lp-OmasA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfXwiD+ppI3tU3w
 pGz3scN18eX73OfSosl49C3msRDgge6E1wdn+d9P/62UdLd0rU1vs1aESbxXUo20dbhWwAkVbTc
 dyWUGoU61GR1PdJ9/yslmUgoW3USm7ecSv14TtbBFBPGdXEQTmYS4MvCrWJlTzGf3BwYIF391lk
 xZ9VKc66EmIORY+w0JF7uQdHkSmmqxUnaJX/ri/UTh3O7JsmifbwT4sLiMbbnqME/o87vG5dAFa
 8hewDTmuGiQYfhpV8mr/gXxutGjZvO55tsAUm12/rkJYQkB/a0bgnoef9A2/dEY/gkdPznjTN5Q
 PEc6O/oT2YYQ52YBRFgO1ByqDW8oYj5J6CA0sc0EoJUYmPjKv4kcUcxT+0fK1t5TeNHfdKdBvQp
 1/rcbo9eIbAKyQ13ynf5yB2cvdWWcElu9K17r6oFwJOx8dBq/CvmYUbtoUpUl/MRINTKbTvNb0m
 4fU2kehJY1XkkK+yiIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
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

Add support for the nord SE Global Clock Controller (SEGCC).

Implement the qcom,nord-segcc driver to provide clocks, resets and
power domains required by nord peripherals during boot.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig            |   9 ++
 drivers/clk/qcom/Makefile           |   1 +
 drivers/clk/qcom/clock-nord-segcc.c | 137 ++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-nord-segcc.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 3cc5e453f66..943405863ba 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -72,6 +72,15 @@ config CLK_QCOM_NORD_NEGCC
 	  UFS, USB, and QUPv3 clocks and resets exposed by the NEGCC
 	  hardware block.
 
+config CLK_QCOM_NORD_SEGCC
+	bool "Qualcomm Nord SEGCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the South-East Global Clock
+	  Controller on the Snapdragon Nord SoC. This driver supports the
+	  EMAC and QUPv3 clocks and resets exposed by the SEGCC hardware
+	  block.
+
 config CLK_QCOM_QCM2290
 	bool "Qualcomm QCM2290 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index c369909c44d..7ae39fa2026 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
 obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-gcc.o
 obj-$(CONFIG_CLK_QCOM_NORD_NEGCC) += clock-nord-negcc.o
+obj-$(CONFIG_CLK_QCOM_NORD_SEGCC) += clock-nord-segcc.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
diff --git a/drivers/clk/qcom/clock-nord-segcc.c b/drivers/clk/qcom/clock-nord-segcc.c
new file mode 100644
index 00000000000..53a8732c646
--- /dev/null
+++ b/drivers/clk/qcom/clock-nord-segcc.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,nord-segcc.h>
+#include "clock-qcom.h"
+
+#define SE_GCC_QUPV3_WRAP0_S4_CLK_CMD_RCGR	0x2665c
+
+static ulong nord_segcc_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (clk->id < priv->data->num_clks)
+		debug("%s: %s, requested rate=%ld\n", __func__,
+		      priv->data->clks[clk->id].name, rate);
+
+	switch (clk->id) {
+	case SE_GCC_QUPV3_WRAP0_S4_CLK:
+		WARN(rate != 14745600,
+		     "Unexpected rate for SE_GCC_QUPV3_WRAP0_S4_CLK: %lu\n", rate);
+		clk_rcg_set_rate_mnd(priv->base, SE_GCC_QUPV3_WRAP0_S4_CLK_CMD_RCGR,
+				     1, 384, 15625, CFG_CLK_SRC_GPLL0, 16);
+		return rate;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk nord_segcc_clks[] = {
+	GATE_CLK_POLLED(SE_GCC_EMAC0_AXI_CLK,           0x2401c, BIT(0),  0x2401c),
+	GATE_CLK_POLLED(SE_GCC_EMAC1_AXI_CLK,           0x2501c, BIT(0),  0x2501c),
+	GATE_CLK_POLLED(SE_GCC_MMU_2_TCU_VOTE_CLK,      0x57040, BIT(0),  0x57040),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_CORE_2X_CLK, 0x57000, BIT(15), 0x26020),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_CORE_CLK,    0x57000, BIT(14), 0x2600c),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_M_AHB_CLK,   0x57000, BIT(12), 0x26004),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S0_CLK,      0x57000, BIT(16), 0x2615c),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S1_CLK,      0x57000, BIT(17), 0x26298),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S2_CLK,      0x57000, BIT(18), 0x263d4),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S3_CLK,      0x57000, BIT(19), 0x26510),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S4_CLK,      0x57000, BIT(20), 0x2664c),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S5_CLK,      0x57000, BIT(21), 0x26788),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S6_CLK,      0x57000, BIT(22), 0x268c4),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S_AHB_CLK,   0x57000, BIT(13), 0x26008),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_CORE_2X_CLK, 0x57000, BIT(26), 0x27020),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_CORE_CLK,    0x57000, BIT(25), 0x2700c),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_M_AHB_CLK,   0x57000, BIT(23), 0x27004),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S0_CLK,      0x57000, BIT(27), 0x2715c),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S1_CLK,      0x57000, BIT(28), 0x27298),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S2_CLK,      0x57000, BIT(29), 0x273d4),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S3_CLK,      0x57000, BIT(30), 0x27510),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S4_CLK,      0x57000, BIT(31), 0x2764c),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S5_CLK,      0x57008, BIT(0),  0x27788),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S6_CLK,      0x57008, BIT(1),  0x278c4),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S_AHB_CLK,   0x57000, BIT(24), 0x27008),
+
+	GATE_CLK(SE_GCC_EEE_EMAC0_CLK,               0x240b4, BIT(0)),
+	GATE_CLK(SE_GCC_EEE_EMAC1_CLK,               0x250b4, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC0_CC_SGMIIPHY_RX_CLK,    0x24064, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC0_CC_SGMIIPHY_TX_CLK,    0x2405c, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC0_PHY_AUX_CLK,           0x2402c, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC0_PTP_CLK,               0x24048, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC0_RGMII_CLK,             0x24058, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC0_RPCS_RX_CLK,           0x240a8, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC0_RPCS_TX_CLK,           0x240a4, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC0_XGXS_RX_CLK,           0x240b0, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC0_XGXS_TX_CLK,           0x240ac, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC1_CC_SGMIIPHY_RX_CLK,    0x25064, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC1_CC_SGMIIPHY_TX_CLK,    0x2505c, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC1_PHY_AUX_CLK,           0x2502c, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC1_PTP_CLK,               0x25048, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC1_RGMII_CLK,             0x25058, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC1_RPCS_RX_CLK,           0x250a8, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC1_RPCS_TX_CLK,           0x250a4, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC1_XGXS_RX_CLK,           0x250b0, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC1_XGXS_TX_CLK,           0x250ac, BIT(0)),
+	GATE_CLK(SE_GCC_FRQ_MEASURE_REF_CLK,         0x18008, BIT(0)),
+	GATE_CLK(SE_GCC_GP1_CLK,                     0x19000, BIT(0)),
+	GATE_CLK(SE_GCC_GP2_CLK,                     0x1a000, BIT(0)),
+};
+
+static int nord_segcc_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map nord_segcc_resets[] = {
+	[SE_GCC_EMAC0_BCR] = { 0x24000 },
+	[SE_GCC_EMAC1_BCR] = { 0x25000 },
+	[SE_GCC_QUPV3_WRAPPER_0_BCR] = { 0x26000 },
+	[SE_GCC_QUPV3_WRAPPER_1_BCR] = { 0x27000 },
+};
+
+static const struct qcom_power_map nord_segcc_gdscs[] = {
+	[SE_GCC_EMAC0_GDSC] = { 0x24004 },
+	[SE_GCC_EMAC1_GDSC] = { 0x25004 },
+};
+
+static struct msm_clk_data nord_segcc_data = {
+	.resets = nord_segcc_resets,
+	.num_resets = ARRAY_SIZE(nord_segcc_resets),
+	.clks = nord_segcc_clks,
+	.num_clks = ARRAY_SIZE(nord_segcc_clks),
+
+	.power_domains = nord_segcc_gdscs,
+	.num_power_domains = ARRAY_SIZE(nord_segcc_gdscs),
+
+	.enable = nord_segcc_enable,
+	.set_rate = nord_segcc_set_rate,
+};
+
+static const struct udevice_id gcc_nord_segcc_of_match[] = {
+	{
+		.compatible = "qcom,nord-segcc",
+		.data = (ulong)&nord_segcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_nord_segcc) = {
+	.name		= "gcc_nord_segcc",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_nord_segcc_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

