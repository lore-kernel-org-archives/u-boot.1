Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE9BCC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 10:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7653C60629;
	Tue, 13 Oct 2026 10:30:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3IltVP25YwT4; Tue, 13 Oct 2026 10:30:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 95C57606A5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791887442;
	b=q0RMvB3OWFXsSKAFrx7jWoEQC9+47sat2wJyIa/6jfgnE5/Rby+HRcc/kN9I6BwrLMCp
	 hq3dEMDNUguj3LrTrNxFlzsCXz8iQ/b7cJmU1ydIJ6A0J5lmCj2pqc9veCmexKxayuXRH
	 KSDdl0E2vOad9gYLpZbWgQdUL4yamh6pWfCwT/rGvAhYmgtxXbQyUst7IlswEOaLk6a4r
	 +vOWnfn5tMhL7S3ZnRBAll0vboe1Jrs1Hz7s1rQgdW1Yu8uoifv4oOX4wWMR64a7LNbgJ
	 YrcrEmHHNu8tLFKd/1H7Pz1uv5VAZWk1oqB3C6DFJiLnYzAFq9C93JO+JtqF/Jq5IiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791887442;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bPUcwfMbqEGerjXsYzmBOcp7Rj50TYby14rNvZuYfU0=;
	b=Utl1QqBKZZHS1czOdkCtX5uGYRACyTzvwb6tbUdYRGuyE+qFKsxdfOUTCpNQaZAkqPCL
	 uDf138ooNkb8smEsobiUAwB83Xz68n0NmwpK80D2D5UaX8BMPvZURyQyaNYTiB8cY1gi9
	 kd+wfjW8Boq+qbjvp/fXaVG2XK5o+fg5coOV6VdeBu0r33+Vl252oPq/UofyA+N7zT7Ib
	 cQ05Bn9LPtE0LlC7DZmoS037jaqlWmV4B7PPMdd1KcD01SMsUNYIVbY8z/GY+90T4NNip
	 4Gc6pWYd/hqR0U8VeMIGbsj+jATLWtlamL43gKENlq1dKwOhaRK8dKAiL5EXCz+thRA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791887442;
	bh=bPUcwfMbqEGerjXsYzmBOcp7Rj50TYby14rNvZuYfU0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uF8MdQQRFvKylp1XiY1jBcP9MEGfz0tRAoSSu1fod6NfhcOEgn4fjg1kXlh/unwNL
	 UVYpEiSmqVanoOoJ37aZh/m5KUoOm16ZOx8NeATPnbZm7/39D/NaRH/24GubxzIARb
	 vhvxE7bfm5C+DhzHlINBUu40IAhBkqqz6/0Pxy1Z3FXJ5uChhig2XGBnTArhFovZ1M
	 +DPhD6JnaqZlIYr9IwpilJ6Pq/w8zsAnSvw+4W00R2c3snOLMFMl6QhMxT1+dUCzKs
	 7DoOwMbx6Z9BlAo0vqFJY6DvzkO3xcd8Lvdfg2gxCpQ4yzLWmeNiSqFer67wtH8Vya
	 1vZ7sLwH7KReQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95C57606A5;
	Tue, 13 Oct 2026 10:30:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E3F0E75
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C95EA80C11
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:30:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E7Gujhw3TTpd for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 10:30:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CDE0F80C0C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791887440;
 b=MemHVwaQBj7AqPZqW78FkdTYp0lsUgG4XPMoBracmbQCCIeGUk062RE02rALRosxLnLC
 cEulMB4xg5wAJS6GeP3K6zaInVp3eLNeX69m6oHLutfTXkGxwIciMmx/bj04udWvKzMoV
 jHd8jRgX+sfNgELjaMcpulzBPfWzBJLPbqnGNS/YiYoeMO6FVqotJ9pxAjqZdCM14qm9H
 8JTj5iiGZcVeBIyLDW+7SWdafmE8bRY8RZktq1Kr07SmMOktkwbRH7w4K59g3logejfRw
 kDdmjM1TEw6E28jcxM+tD09zW/RjyUlg1rWth5xHr1qGuQSXxZJWnyZFbl5c25zYpbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791887440;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=bPUcwfMbqEGerjXsYzmBOcp7Rj50TYby14rNvZuYfU0=;
 b=IPoJJTme1BvSGtopTpX42LD6zm52bdei9czyIgSfbdF2Df73lwuiJdLFXLs3RBhFvb6M
 r+scjqVfT1ZX/1Zj6+IC8NzF7c1+Y95zcBJ6FN9e+NchL2EmIK8bT43b/LXXnkks6QBuZ
 e4bSk5IKaS8sL+t3Y+6rYMlgza917XUiABOSVtt9MWOq7JtJlRUJuCS2Fj+ADUKoir8rA
 PqYGjwQJj2oMCn6CQOvjf2xOq0ic32NV6bfGlGk91+IYjc9RbeZ54PypbDqy0tnUO3eEf
 CfSBo8PQfAMT0XCAgVNxCFdbdVkhIkbESCvh3NyOibQk4BSwUZ237G4pu3pqfk5MxrA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=oaoOmxI0; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=baikMJDd; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=oaoOmxI0; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=baikMJDd
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CDE0F80C0C
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:30:39 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8xvW8790919
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bPUcwfMbqEGerjXsYzmBOcp7Rj50TYby14rNvZuYfU0=; b=oaoOmxI0bEwTpOBl
 z3PytGlK8MTqXBKmmI16V5LCHL8kfYXrMTsNEyCMi44QDNqBqsUBHMyHLtof+tq8
 mxHq4WrWbE4EJYldFPI5rqbmVClcaZe5w1Sc6PGEIXcmluOQfboxZ1EWv4M/l87c
 OLXnrLY+p+YoSjs4ffuCORzfO+JZ0qxD7uNn09Cw3aueHNmm1kRRr0MVn571lJuR
 vudicRJGQ2i35GGKypPCYd0sCawbq9MeIVlZKDhc4IrfCVu46ToqHtk5kLqjeZEr
 EClfoZd3xpdCHsGUfLOYofFRp+kOY93hfElUmwmXCXjGBghfAIzsI18V0ma+S5zM
 FCC87Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9hmjrcyc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:30:38 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3580c07911eso7394248eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791887437; x=1792492237;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bPUcwfMbqEGerjXsYzmBOcp7Rj50TYby14rNvZuYfU0=;
 b=baikMJDdGNgvlCerRJIzfP3yeHAHlR1YiBysgz5SOFcLpAHSdpYEouEjjoNwcGgr1G
 XuwJDWQF4E6FHkt1+SQPDYl1b7HkuHKJUNJQ8Nf7kARNCIWGciOovBnoUaCAteUSeprP
 9oIcp+Zwcrp1k1oIgunVda2nekllFkUeRAhAEgwcwwdaqalG4BEI3XbLM8u9XyqcIwXA
 YC4Dbnu/SIsZWyT+dCrh1IpyBkLadHopcaOE7ME3cfWPood1xLqBQUXlm7WBkHPrx+1T
 cerV9ye4YUfavwVHA2B8ph1LUlYelBx8TkxiqDjDLluHkAScCsEoC0ljfEtz8dGGl+iS
 IpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791887437; x=1792492237;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bPUcwfMbqEGerjXsYzmBOcp7Rj50TYby14rNvZuYfU0=;
 b=0Mkm/fWJxWGVHPUscKCrxJ6Y5RyYtb1rQxOHWVYnGSfuWrf+la/swYFS0HyStM4Jnk
 cptaPVuDYqdGJm7cqIhOD8EDoTT5v+d6z01Ay058rIATg2NqV1hEAl0n2EHoVE2YlGwU
 66wnBF6vZEYLNDufUHztwxZnz0sSUOMVAXbIhOORXy+FBy2KaVx5dZR7Ms80lr4uYWNX
 pBDnB/LVg23Wi6uD7CA6np3ZNfAjVgGE9DKqvHzD4F3sLjY874n2/h9GJdReIIiSDBOT
 hbKSvuB+x8pVkhUvaSAzpUW9BXQhy1oja4A3uf1e02vdKJSMUuCiRz2WP+/ri3an28z3
 gvqA==
X-Forwarded-Encrypted: i=1;
 AKwUvByuG66I+1VdwwHSkzmaXOtqp0MVF+5bW/BlCzfkj6ieGGt9T2InnrGxH5wpeHv1own8R6rNFRk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL1ky/Gm12bL5USTJliJx9p+cHIUaqZGO4Ods24qhPyVJQPy8pi
 6VrZcoeUj1+H70oMIW3HjBz2vMvDSSl0XO6pEjZ2dSCUiUu0Uo2XoLx4t+dKWYwrMN183ZvHMff
 KEb748HYOSAoJwnbnCmp9lD2Qp2BcXQuHd9I6ooYB9FBUlGaZPUyIxLyEmomvi2V/xjpQkmY=
X-Gm-Gg: AYBFou3Ogl5gHGa6zXR8vvsGAYPloT39fTu4T/p4Az7JLyfn6MuBlqf2X1E20otkbK3
 epx6wT1jeSfc1mdEEJjCNI4LyKVcsrVm6h6qnvSDGJav7M9k6C3xP9GkXRZN8Ue1hMeoCjgCqvc
 kUFN9Dtd1c05MS/Y5sES+6hfgdVwLxX/mZ4Ic/WlC0cZNQq8qoOwhwZXNlgAhROM+bh+BlBfOsm
 zRZcVXj9QgzlzDcWnpVJ0M3gLJyejM7ohI3Z6YDr/grW9RTX0mUTkF8g+jl+4C2Ey6hUq4TsIvv
 2YuGBjnalxfLJ8vyXlVe7vWIYloGh+02uehUwB7VEoWfdpKqU+/JkRBLcBRpsdVZbxtRWSAMP2I
 VvZ+eBQe0V39o018qafnNLVM0gsrR
X-Received: by 2002:a05:7300:aca5:b0:358:1f59:48c9 with SMTP id
 5a478bee46e88-3581f594a27mr19160641eec.24.1791887437206; 
 Tue, 13 Oct 2026 03:30:37 -0700 (PDT)
X-Received: by 2002:a05:7300:aca5:b0:358:1f59:48c9 with SMTP id
 5a478bee46e88-3581f594a27mr19160550eec.24.1791887436189; 
 Tue, 13 Oct 2026 03:30:36 -0700 (PDT)
Received: from [10.152.198.236] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35977229a6esm27487209eec.8.2026.10.13.03.30.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 03:30:35 -0700 (PDT)
Message-ID: <874dd32f-2449-4984-b4e1-4d301a507cba@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 16:00:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/13] arm: dts: shikra: retain QUP SPL dependencies
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
References: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
 <20261008094912.419090-6-abhilash.v@oss.qualcomm.com>
 <20261008124457.2d266c58@karo-electronics.de>
Content-Language: en-US
From: Abhilash V <abhilash.v@oss.qualcomm.com>
In-Reply-To: <20261008124457.2d266c58@karo-electronics.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX6LpcTbFk9pRR
 b3rTggG//hQUwng20GQriA4iQmGDsKJ0v0iHywRHqUh9HNqeYG6Ey+3KqAdmcAgDQvpbH6Hkbiu
 9p0tHIxamAgcQdCh9PfCjcBW1ktGbLE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX5AHaKIIloJis
 jquDO0ELJ007AJ3qalKh7egNfn/prZhITcqKdbbZbjYBn7OF/xR7Ygb1L9UeHketwIIA+dwlRgK
 vm86xdpMqyMSYFK6K2rJ0AzZmtvSFie+QESBXaoHP75/JzHX9XG9xevHPeV3ds/oSoLKwkRKo7I
 X3lc/0gxuK2vEDxc2MuYMPNfqi/yBmw5JpH8nOVreGJ6d2wrdEgqRgUrpMiSRnjXKNAU1uSNQ7h
 KMM6ysqcMjbIjAWpX6uVzU86SzPGlr5MEti/3RX5SN8omMjuyVukYQr5zr+rD25zQotVI4XiWNB
 JeMuNVvVa0Bq5esaE35WqIdb2/B3sb82fGzOm5o6dB+/isik3pgyMt9LOeBr5ydVoHS2lwqb4Dy
 SGPfAujJsQ9nJsXokcWuGOvLQx+9DMSQznl4ZHdF+27GHiEDRYcNzIb0XBrVRV/fkQh/ymjSULk
 ur02v1tPAuhc/cWmepw==
X-Proofpoint-ORIG-GUID: -YDx8ngyYyVA3IP0vKwvHoRwinH2IBmC
X-Authority-Analysis: v=2.4 cv=O5+sLx9W c=1 sm=1 tr=0 ts=6ace084e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=C53SPHxk9BetuBi1QhwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: -YDx8ngyYyVA3IP0vKwvHoRwinH2IBmC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130041
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

Hi Lothar,


On 10/8/2026 4:14 PM, Lothar Waßmann wrote:

> Hi,
>
> On Thu,  8 Oct 2026 02:49:04 -0700 Abhilash V wrote:
>> Retain QUP, console, pinctrl, clock, power-domain, RPM,
>> and MMC dependencies in the SPL device tree so the firmware
>> loader can use the boot medium once probed in SPL.
>>
>> Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
>> ---
>>   arch/arm/dts/shikra-cqs-evk-u-boot.dtsi | 44 +++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
>> index e807b91ef1f..e8831da6aa7 100644
>> --- a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
>> +++ b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
>> @@ -20,3 +20,47 @@
>>   &usb_qmpphy {
>>   	status = "okay";
>>   };
>> +
>> +/*
>> + * Keep SPL console and QUP dependencies.
>> + */
> [...]
>> +&rpmpd {
>> +	bootph-all;
>> +};
>> \ No newline at end of file
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>
> Lothar Waßmann
I have addressed this issue in the v2 version: 
https://lore.kernel.org/u-boot/20261013053244.2954876-1-abhilash.v@oss.qualcomm.com/

Regards,
Abhilash
