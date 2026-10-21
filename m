Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70A4606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=frzyu31o;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GEoscsjE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lhr902wO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3D6A40889;
	Wed, 21 Oct 2026 16:06:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id av16x3E5VCKC; Wed, 21 Oct 2026 16:06:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A89D64089D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792598773;
	b=hBOdRYQr63pbcOneHOPSRqwO89Osz0U2aF6RVuc7RtbfdkEm7suozMKcJkyekqg8IEpy
	 ruHVQ3K+E/1XWHEx7BYTyDDjDzCt+2z1UttOV0l/Ob0L6Z7T89oiKBvL4V+NjmHWdHAAi
	 e7cOz5xz0eWTTsK8dAcIP17ILaQUD/Iy1ZIgtEiDmgGgm57Xcq9KCa0htidfkWcEnU5H9
	 /b3ViaB1QepBr47waH6WqZVirofmPTGSMSlzdem3y+ZqQ8vXu0Zdb691riI/Q5j36/kgT
	 AVXg9MzkZ0tLFAfCh9OJS9zWInM8WANKl3c/BuVdi/J2yzYraJlep1NfZ934vHgGWQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792598773;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wgHezY5Ovx9OhbU6B0Icvh5SUZzaWHXC5UF/lwSDAD0=;
	b=Ava1mgKgPAfU/ogaoI4KHYFQqM6PuPHK9wS4hktuLP0VY8KIJzppnFG2nfoMVj0X6BPx
	 tr5AKiSiSHTOUdfZxxyuylI7ZEDFrROoK02Qh+/IadW0J0ilGoqbY1bv1b3QvyNa2zXGq
	 T7cw334/BNalEIe7F1T83CxDtgV6Y1JnRCGikNop9+w5VJWgem2uyMHWetQ2TMiagKnBg
	 CEmE4e2e17SMYBvxn2gBotjcyJJmaM3dTJdxUA7/oOiAA88a5sdTntnXCCKYO7Cj6SXH3
	 D2cpVArOZ3kSyb43KVTxvusya+SQtUOaq2P+zsZ3NIH51A48BWc6rk7NycGiTo/eASg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792598773;
	bh=wgHezY5Ovx9OhbU6B0Icvh5SUZzaWHXC5UF/lwSDAD0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=frzyu31oq//akQIAzFTe9Gth6/vnhuunKtTllIEB6wOWretL6YhzHD6KGjDuIXCw9
	 W721J8JSMaPxx5EkhGHNzonl5Y9qQ52jchrCruryF0MenHi9aKhqjSdg9STx8rmr8A
	 5yVKdXrdR03OLHvTjo15VduFRn7jSdkncAu7i/Termu44fZ9GUNbhxiot3lm2zvrpV
	 mziX33/wQkKxFdbyxJiPtjfuruNtPT3a6etJyvOmVw2rqgFtDy2b7ekgSZtAW4RTft
	 8/wVAYw4GhWxoyTv3gio0EY2RvlzNv8S7smXqs6tdIksKUVvwTKnJevq3qo3m2fp8e
	 ZlVCQmGSWNVaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A89D64089D;
	Wed, 21 Oct 2026 16:06:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8216B356
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 709EC403B9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:06:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hbfqfa1GU5rk for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:06:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A86374039F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598771;
 b=SqYyw+BzZBJOZzrlpug+bu33vw1cMiKP/5anS0lC2wYZASZtNY5ia2ELhmn4UoFiWC72
 P4f/jB9AQafI0u+UWhf3DaYfMvBgoXBu6OhWYkXBCsJCuwalINlSmFq8hBXBVYyYGBhDH
 EBAWwOcJhzRh/lMST4wPlJa6gaQxTVStfvANvfMRRkLlezfDbMFEygbMlp6YNPvj8xPXx
 vLCHsMuQ+D5g0P89157Z78e+lXV6zVsA3K8Qzxqq3nXcB4AQ9eTQbOh3MfYqvL4ionLsH
 qW/OQouwzTuDnFmm4/gt+ooKceEJtqwf1yJHRnrtvyf9J1wU+DQe93LXdOZlZ0GWBxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598771;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=wgHezY5Ovx9OhbU6B0Icvh5SUZzaWHXC5UF/lwSDAD0=;
 b=kRI1+mnOnPMGoABNy+6G78XcOmtnVV8OKfgPdDF9IaJi28PoRxbzoGIk36UKnnWwdrJY
 ygUm9sT8JsnzWC4hgO6PN3j6bWc5uP7LC1Ev4h4W3jtIer+Q8DIK4eQpke8jv1ThXxYRR
 se68C7+VG5+sg1zMGJacZ1s21ee1uicmyB1ETuroPADY2g7lKkcrUqhE6MpV1626GvgPl
 LDFM+/0edKI56uRII6pr894C8nudcKj9uOYYWrMkLlsbJeeAJ6J7wZ26ueiqEN+RrNSw2
 2JyiAP9zHXzk8rusphm5WyOtjxpqvHd5zLztrAoRQr23WiBsRlx5hHVfb2yKoYCjd6g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=GEoscsjE; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Lhr902wO; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=GEoscsjE; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Lhr902wO
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A86374039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:06:11 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU0hw682124
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wgHezY5Ovx9
 OhbU6B0Icvh5SUZzaWHXC5UF/lwSDAD0=; b=GEoscsjEov2gzyZtypMCOqroumq
 kM11ZZeINNzhsryqmqzuQ55UFTLmYfTP3BwiyL+jYcx/JH5V2kZ3zCJT+sz9tiUB
 RHCO1Iag0tbCjpAoVwRr/iUEEmm4y9rLnWZuR/6O9MizdlSp7P6SXI1SMw5QzuE3
 Cx216JElhPAKh/Zspk0sRtmDhG0nzj1xueqEOGmW2kLZ8Ei/O/SWzGz45tdhGQol
 rTT3NUE9/Oxalj7yEVBGOTvm6nnSP1CGoDxPCPVLfbzMj55Aarp9tmLJs+f6FgyB
 WE85+aHNLJp+F4ULYclrS7frJnKsKiAI+74IeV7wVSSH5RHnD4SLO/x6H8g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex7vrr7g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:06:09 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1665200f4c2so1271392c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792598767; x=1793203567;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wgHezY5Ovx9OhbU6B0Icvh5SUZzaWHXC5UF/lwSDAD0=;
 b=Lhr902wOm/40hOzSLzNYDfLrbyIBeE+Ehpduv0qO25vSIIn20q/fXxNxjVHqI13fhw
 fw5vTHxcIRrbTjgkKyRI/VMYThPBc3lpq86wtYXCBynv0fgF38FXmxFFGk7s2yja1IZ3
 tePe/sO5H9Na+Go8mtIy2I6QQbxqUH3icDNVKWr9w/sd+pMOYgxhR1P2JICpxLNLJkrc
 EIvHe4CoKR8S5d7TyEV24uwLBENTRckkI5KDhiRKuOvn3hvy6biYHKkgu2QOXH8kNljT
 Xlp/tYBXWyw4/n7HEhzRujblcu7SbERDQqHxJwX4vYcBOLi7HNn5EO3Nu9zXu8Phl1KG
 txnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598767; x=1793203567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wgHezY5Ovx9OhbU6B0Icvh5SUZzaWHXC5UF/lwSDAD0=;
 b=JV/aRIItJi/sq+rSDU76u7h+zzEjvpJWhtgiiT+Y1QEl+i8tqzH7OQxtjoEyONt6+v
 e95lN6ECretkheg5gsiCC1lPJvYQ4ojTNQSb7o9DMHiuAAq47Kn0LMFJeaMS9tLIt3Eq
 i+O0w/e4S+BGLw4F9818jy3n6bQ9w73shwevezMbDCaDfsWt2fRce54WIPVZH4ZoULlD
 LmnNqP1iyPDqFIZO79YyNlmwftzn+54fpwjO8+fNDA2K5aGkpLKg4ZSjZ6pTHb2Kf+dM
 yYV+YwW2bMA/Pa6TJTzbD5itSbgxNJoklC8RUb69zoqR7AhhDMrH40WvqghIlX+EJWYk
 zDBA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzA1vu1kH8CD7PchTaSVcN0pZhWfZucDVW+5D2L4BH6wKfACfHlyCC/Eierl47p0lSKBgJs5bA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLnp7hBNzXwBeUdYc4jj1gefW6PJUZJCo8OtFQOjQpqrm4Ef6uA
 WtCOFlqNNO/xs5vWetGAV5b7lJJh2j9MTaRiRpe1qQnV8gpdMREOUVQUo20HAee1t1Ojp1SGCum
 zGweA+9CbVycVcWz72CtjK2kUXyfYf7MEiUTZzjqPEPaBqUZ2KMAbR0Sj0arj/H83cDVHwf8=
X-Gm-Gg: AYBFou1gIMJTURcLLXmYONbw/fAMC5n/NzqW4kxndhGJ99vs4Uac0EY7G8qlIXecp0O
 PLzMrmFKX3CW/qzl+FIZiIT4DlGsCetZSNzSoBWSfVTEfY9P7ulatXmRNXfRWA+nZyutbfRj0DT
 NlLWAfJdJ4Lo9b0heG1LUnOzociw7HCmPuwtjMjGBiiHqqOHGmdL2Z27PTl5k8XFXNBV9zOz0JC
 RX14en/h9rx51v1anV8GTo/yjB4FUR1ig6Lp1ohEtGKF6+B1pt/UcREG79KoLRCfa5ArVE6kqH9
 PYsJRjrYdb8qxf+ocw3UMQYtMdBW4jx4ytNGynLqVaf5G2yM92Eh/mJr7e5Zg5SkMOqbk4BQCD9
 zqAIBzTvi5pA+qcFYO+jHQhqSh0zvaWl5TLMYjTiv4QirE/qHx4RzoCEzGaKbPr6gRvTPW8GHjO
 /9TmYuKE2xRqReFTkdQC8=
X-Received: by 2002:a05:7022:6ba1:b0:14a:5284:1bf5 with SMTP id
 a92af1059eb24-190a4a34c1amr4207280c88.13.1792598767364; 
 Wed, 21 Oct 2026 09:06:07 -0700 (PDT)
X-Received: by 2002:a05:7022:6ba1:b0:14a:5284:1bf5 with SMTP id
 a92af1059eb24-190a4a34c1amr4207244c88.13.1792598766670; 
 Wed, 21 Oct 2026 09:06:06 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903d3ae06fsm7480185c88.19.2026.10.21.09.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:06:01 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, aswin.murugan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, nathbappai@gmail.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, jbx6244@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 8/8] phy: qcom: snps-eusb2: add Nord compatible
Date: Wed, 21 Oct 2026 21:34:48 +0530
Message-Id: <20261021160448.3893858-9-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
References: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Dax2KFRbvPHFdIP4RDqfHgJq17HU_n7H
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX7kXDZ4rh5kCe
 6VCJKcFxOahUjYUNiZwh6z90TkMXF/cRilJ/4NILB1EPwXJZZX90fMROxDsDk24hESjsupAyd2z
 IiXXuLBECwMktT8K+ZUxxXmv1D2pAxg=
X-Proofpoint-GUID: Dax2KFRbvPHFdIP4RDqfHgJq17HU_n7H
X-Authority-Analysis: v=2.4 cv=e4uT2qp/ c=1 sm=1 tr=0 ts=6ad8e2f1 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=2eSpjYXTIbo4t31u8wEA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX5mdZTLQ+Sj6l
 9vzqMuMoFU25j8EJaLKV0YaWo4KmBXlYeUlNeOy01iU0+270xZfrqhpgDFOHJyUS3jCo+9CjqAW
 tN+jMpJCY5zWqMHRmTSTvAfu8OAqVnaXM4SSccc/0Uxaq6EAZevGmlUsh3VVpfM9ev3xUBag4tE
 5z+DMXfQxjiKS5T+3vT6l6RJiR882KXf9mIKSoVFD6ouqh2VQAidvHaEc41xkBb4Ihpp8+XzKX7
 N9TludMz+l6M7PIznHkfth9GG6PRNeWRTChSoBQsIox81SMaFOFl1A/p7B7cjASB0W1rWJjjVbv
 zWyDDU5cMh1cOijpjl/PnGzwDDTKdbXvpKunXQFWEwfIkAShX166n69/Nr6lj9DAWBjVmBd42C9
 8YFTC9IyJL/uFdmCK+R1zEBvrB29IgK1F1wC54URmUvNK+SLpV2+Hd0IngnUBQqWqgy+H4BIZm2
 YVqtFjKgB0vkvmsE0mw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
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

Add qcom,nord-snps-eusb2-phy to the match table so the driver
binds directly on Nord.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/phy/qcom/phy-qcom-snps-eusb2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-snps-eusb2.c b/drivers/phy/qcom/phy-qcom-snps-eusb2.c
index 28502c46f67..8bdd2544443 100644
--- a/drivers/phy/qcom/phy-qcom-snps-eusb2.c
+++ b/drivers/phy/qcom/phy-qcom-snps-eusb2.c
@@ -354,6 +354,9 @@ static const struct udevice_id qcom_snps_eusb2_phy_ids[] = {
 	{
 		.compatible = "qcom,sm8550-snps-eusb2-phy",
 	},
+	{
+		.compatible = "qcom,nord-snps-eusb2-phy",
+	},
 	{}
 };
 
-- 
2.34.1

