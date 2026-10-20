Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB8606A32E
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t71L7ACc;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EDGDusFk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X2rY6MPi
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12FD0608AA;
	Tue, 20 Oct 2026 15:38:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ch_UdMV-Easb; Tue, 20 Oct 2026 15:38:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C65AE60844
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792510720;
	b=ifW9SF+2tXrDBDcP9ffRLk+CXcx7tel/JK3rLpOA0Q2ykvdclA/Jhx9CTsnwHaXCUIM7
	 cJgUNk57PHnNMumHCtxZeFJHMzJS/38vN2E1iLKeaNm/2ykDKdIM9B65eKe7a0mcXFUyj
	 ArtqTKBM/NY3Ur/12Z8S8TKzDZpaiv8fq5yDcqpJ86nV8PvG626Ev874i1zq21cjb2GY4
	 2ajwP/8YLym4yV4xBcToSk2eVA9jfrQiKY96HTwxiHCxhBY5IGf+4FbeWWUAvtxELBNYV
	 BU59wGLoGO4e7kSwxoc6pLEI/bG062PHyDjjm897ogvPaZ2fwA2KlilHR8zm6NJlRmw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792510720;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vpcHPqYRwxYV6JxW00pQGV4iZLyyRalww5ts4GEgYkM=;
	b=hcJblTtBe7lg4A8SajR2h/Kg75+AAEbikUbc6iBAm3ACplPbyW1naYVBCjMGxFjCDXDq
	 N3V8lA+Ejf5GrpolRKF2c6I5DQ16Hh2GJeBO1SH0EJUBdyop4e0idc2AWB/1F80f4Wsjw
	 qJ9GrIlPIfZd5B6A6s4eGwf+XoOswKbDcaZgtFtuWAwVjhpTOauqaNajbg7aAwjTdqj4S
	 4fGLRNn0mPSfmd7iI6RzNpxCw379oMpzMPp+gpyKYhLz60/jKjahtSBSwSGJe9e2ahJ2J
	 4kHDoYFk0AQsgiZHv6XV+ofxJbs9ekT0C/84fndw8DwOwJMZ7tNADp8/5jWMG/wNfaA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792510719;
	bh=vpcHPqYRwxYV6JxW00pQGV4iZLyyRalww5ts4GEgYkM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t71L7ACcy120gqUg2ad3P6oxnKOvyZ7z+mmR3Kpj5eip6kZp0yUyGO8TTN3m8vo/c
	 rVG5Ksj1htynpIbDUtsrmeOc5RmybwXOmQNNZbimluh8V2mP9sQtfCeZCIYon2gBMz
	 ePMB0f0z7sri7IX88AsH2oMTD62tH2bJpskesfV6lIVtj7CBWTtyeoOlsROb5VkQEe
	 ZX1HaN44d3l6CkBmqioXzoyiBIT6WZ1VRUYkL9Q/J1+NbcQgGVFpyBjjt9FAlnmrde
	 uMfum6U4s8VzzoZIrdZZbp0PG3H5rk0bxRc359uGt9+6lwdoTblWTiuh9Ur+xNrXeT
	 CX9AJIPMdTlcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C65AE60844;
	Tue, 20 Oct 2026 15:38:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C2C3411CD
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B4A2C8110A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wANTOLPmlHYe for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 15:38:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 898088102D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792510717;
 b=R0iZ3BwM6iENgX4L1unVG3mJz81RuMuambVSXYdXkcn0lLWxgevuFvW5up/VXTrclWxt
 4HBvUzUYw6WVJmt688jAl8o0zptUauQguRc/a+gNFQH0Ab0ezR8xCi89/KEeWlBY3XwMw
 /uese4ltifcvpTZ697V3FZtrhAYS3/15zXQX/UYg6HjChXOogqNqynSFrx98EjFPoJwWj
 COqzJWpuVXJImueyBAX7WLwptfRgyDug76m71xk9pKY6sTwfO781ywPTPlv/z5lEtvL2n
 GvgsIEp8r/4DtSu24PQx2omxqmXTATpXsP0drP++A9ZlWAXwi+JUrlJfqsnugzNj1Cg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792510717;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=vpcHPqYRwxYV6JxW00pQGV4iZLyyRalww5ts4GEgYkM=;
 b=Ahk3C3XiIw/NHZ4FbMUHFHFh8DasLanSY09MUk0DE/w+9SeM4PGBwLuu2LqoM3cJp5VZ
 cJrggU2ZayBXtPtFc882HwEU5jek9u18bFjM4xgTA8L8OAOTpy79UvaMuThMGuW3Nfbz5
 fku7xubTeZHZ3cH/ejSdbSoG0dwSMN7awJ2O0lYSfGj0GQ27oMlxZxHHX2EaprkqrFriw
 tGeyLoliIRisJlkNn52UoYiGlXwVD7IMNDPZh6j5sDF1Q+1J/s88RMVoIn6N4esAylk62
 jG33QCH+umF+rpGGDT8AVkUkB/3p1fQohB2bxL+ALJ7eA/1LRrXXtZGxq7ABh95BL+A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=EDGDusFk; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=X2rY6MPi; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=EDGDusFk; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=X2rY6MPi
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 898088102D
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:36 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KDACRm1429966
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vpcHPqYRwxYV6JxW00pQGV4iZLyyRalww5ts4GEgYkM=; b=EDGDusFkE9P3/Otz
 o2ggmY1D6JLPFof1GQK6gTYIcy7cHS9YZubL8yob1X8zzMqSLm5WRN7++qB4baGH
 jv73c5SNOFmwkQFhAEPeL/+bw5veiK6IUf8RS8uMwHbMG+Rd/9EeTIGJ3Fffa8R3
 PyxsL7rLcTZwCahrDqYZLSh7LGWkROL95gx85ZQkMHq7yJuZLbN4zklJLwMdnZO3
 5ZOhHFaBY1xiE4tzechnY4KE7njBRVv3pkjSVV0cDVJV6OOR4zEBfrazzxRb0MU+
 0ASK26F4RmZcYOZB/wtUioAz2c8CZ9v8xZi+7VJSZDrvj2UjsoSYQ7MakKpR2RYF
 2k5nrg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5qb5v3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:38:34 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91b8c60c550so90198046d6.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792510714; x=1793115514;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vpcHPqYRwxYV6JxW00pQGV4iZLyyRalww5ts4GEgYkM=;
 b=X2rY6MPiJ1WgDmEjGx0HlnEbcOBqVY3lzs33EnokIzuNau6kB8imgK8e3+2kymHS/u
 o9CEMk6fmQ1OBNyNhzsKUEVM4Hj8/Yg1908hnD32fcXJftS09WxW4tMfhM8hnMDoxELL
 e2Bx9GS8AjRngHWcCkvKj5JGdU82b9C8uReQP61/3R7LwGUzCbhTbwExxwZdxjn7dWYk
 yjzw9bQn8IMNa8FJGLwddOuhLpBkGD/b70FGJFHN3Ki4e2+7ChK005slriUMNi5lnQnK
 cKNbLQr/evoFCaMPYuXYYgXYFyZyDsJOkdfLcIoB7XWa9jqkjMl/UKKDcVIpSQQMgYyB
 96sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792510714; x=1793115514;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vpcHPqYRwxYV6JxW00pQGV4iZLyyRalww5ts4GEgYkM=;
 b=lh0H6Tl0pmCPGArtrK07Pnzkztl49Tk3KB+m3AUNUSLaWrm9VQhkHa1LdrNHS2hN6v
 xhUgPlOzHdQaGfhVSEYT6ph00cehKIhTckll/zSpvzPilTCssBvPy2RriGYmQTrFQkbu
 6NYr7CAuxU8sgGpSXoc0wUw9p6Dv6OfKKtiLMt1xazCTS18pY3z62dfnXsKt1cLJOpSc
 kEboNmS80oXBG9s9Kdj0FG02K+4lkVPOR1drkWIUcXxgchreZDyrmQoGo/0uPTGfIo32
 ujp++ThcBor5hI6kQxyaf2YL6QncRVtc1zBRu/225r2AYCx+ny24PAiKwlXaFuTAYBLq
 r6EQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoA0+WnP07Zn2Q3zVZbtMqMuIdyas3Zx6hOGHgOy89hxbj4RKZYs+yenG5GKMK8+r5GhVrexc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIFiA1VRsCoDZxT+l+oMomKKBOh+feA+8CnwikB1pvfKXGO9IJk
 T4KO/RVeA900S5Ttdw2OzPLbb7OgfhGMQ85ZFJ7MqD1ttukSOl4ZxrlUVshpN7amDUXA5bkuT52
 bVqA8aYYQkdHAchzx3HaqnNCi4r8/KiKLlelHES1uOiw85c9V27tqoEYZSXrwshcWo07uyYU=
X-Gm-Gg: AYBFou0quUX1GiUmztOVTKH0iSviFZpFjYFbXVw9lWeE6PqhAyU7vJnHRgmMEk4B6Lg
 rhgHm5xBkMCoBGz6fbtACCzSwrjICkdAkn2i+z2q/HPw54/IUKpqDMA4s0nfkZHs5JF0otwlzCE
 mm7ok777MRJPsnvMuFUA5oyKl3AW2OUT62L5bBUXOX00MTUayYfBH6lrsUhwqEpm8yP8Tgy2wF/
 f/ylX6bgIuGD0vRpvV5553Mej+xQb5M7E78ui3e5UiYI6vt2efSLQxWgmW/WwOlrLmesA4LZNr2
 dBJ86//inckWRYETuTBYtxiRlgcbldDcB4Jwefu1VxjzztNQk/NsauLi0FgNJxPqLKnu1o+n1DK
 93l/xjzohD/wzhepLHKGCLn3uDoevt3isVO/nu5quxd0l
X-Received: by 2002:a05:620a:4416:b0:93b:d79a:c462 with SMTP id
 af79cd13be357-93f29d95c80mr1799619685a.58.1792510713956; 
 Tue, 20 Oct 2026 08:38:33 -0700 (PDT)
X-Received: by 2002:a05:620a:4416:b0:93b:d79a:c462 with SMTP id
 af79cd13be357-93f29d95c80mr1799612185a.58.1792510713189; 
 Tue, 20 Oct 2026 08:38:33 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b38a1b140fsm5574963a12.9.2026.10.20.08.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:38:32 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 17:38:10 +0200
Subject: [PATCH v3 3/5] avb: verify the boot images in the buffers they are
 booted from
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-upstream-avb_lock_unlock_b4-v3-3-e280795a98cc@oss.qualcomm.com>
References: <20261020-upstream-avb_lock_unlock_b4-v3-0-e280795a98cc@oss.qualcomm.com>
In-Reply-To: <20261020-upstream-avb_lock_unlock_b4-v3-0-e280795a98cc@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jan Kehren <jan.kehren@emteria.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: muT4WbNCaa7jqYqwdXjLpryxLvigVq80
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfXxk8erO87ZV/n
 wu6JmJLI6eLxMBv7WEnRE7eXPNW8C/BY8jHJ0TD8ds6XihbL6a1ejiZURQJUwCyE/dgpo74/839
 nAmwbbXpKi+mwylqkt6rUwumF5PK3GW39/nfGyOzyYhbW36MT0g0XKn8XyIFMtUEXJIJaZZoMk6
 40bzsH9nmtD/xwlYEMwAubnI8/du2OpNvLppkkzR4f8CSPyr0lr14N9dsDoaKysJ4TdZmMdg440
 q/q3BHF0guq0MJTisXeQMTiRopmbFJHdhWWf40CblBXkhU4efEFaY1HreJv/fb+AZW4XoDPS5X1
 /MtV+hW9nBUT6V0jAn3ZoftOe3fURJIcLhhnT3HDMx4AYBYGgLn8jyshJ0lGbOZ5yhYciEbdxLU
 hppzQ5flStTEaua4r1vGwknjbSqUCPRo4djaWJT6ScDKTZmVcXRh3lqzG+g5mj+K/dmjelzynzp
 SXczDVNoUgtqq8s1EwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2MiBTYWx0ZWRfX0EpcKXehLVU6
 uHrlM5uk5j+Xe6JD8DCCQB2uHteYw21aDyURNtw3yGzCxphrm7dZ7C9EeDuwj3s0hIhJOny97RW
 2PLY9EJ9Z7Jpgb5rPDsqLPhGc4xpq9s=
X-Authority-Analysis: v=2.4 cv=LpcHWXdc c=1 sm=1 tr=0 ts=6ad78afa cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qJaU2Z4SIW9asTuPRKsA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: muT4WbNCaa7jqYqwdXjLpryxLvigVq80
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200062
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

bootmeth_android let libavb read boot and vendor_boot into its own buffers,
hash them and free them, and then read both partitions again to boot them.
The bytes that were verified and the bytes that were booted were therefore
two separate reads of the storage device, which an attacker able to
interpose the device can tell apart (reported on the list as a TOCTOU
issue). It also read every image twice.

Load boot and vendor_boot first and hand the buffers to libavb through
AvbOps.get_preloaded_partition(), so the hashes are computed over the
memory that bootm consumes afterwards. If a hash descriptor covers more
bytes than the boot image header announced, the tail is read into the same
buffer, bounded by the partition size; a descriptor larger than the buffer
fails verification.

boot is always loaded before verification runs and vendor_boot exists from
boot image header version 3 on, so the preloaded buffers are registered on
those facts rather than on the recorded addresses, which do not have a
defined value for a header version 2 image since the bootmeth private data
is not zeroed. Allocate it with calloc() for the same reason.

Fixes: 125d9f3306ea ("bootstd: Add a bootmeth for Android")
Reported-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 boot/bootmeth_android.c | 73 +++++++++++++++++++++++++++++++++++++--------
 common/avb_verify.c     | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/avb_verify.h    | 36 ++++++++++++++++++++++
 3 files changed, 175 insertions(+), 13 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index ae05c084883..6f7e232d2c3 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -48,6 +48,11 @@ struct android_priv {
 	u32 header_version;
 	u32 boot_img_size;
 	u32 vendor_boot_img_size;
+	/* Where boot and vendor_boot were loaded, and the partition sizes */
+	ulong boot_addr;
+	ulong boot_part_size;
+	ulong vendor_boot_addr;
+	ulong vendor_boot_part_size;
 };
 
 static int android_check(struct udevice *dev, struct bootflow_iter *iter)
@@ -235,7 +240,7 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("bcb read", ret);
 
-	priv = malloc(sizeof(struct android_priv));
+	priv = calloc(1, sizeof(struct android_priv));
 	if (!priv)
 		return log_msg_ret("buf", -ENOMEM);
 
@@ -353,7 +358,8 @@ static int android_read_file(struct udevice *dev, struct bootflow *bflow,
  * Return: 0 if OK, negative errno on failure.
  */
 static int read_slotted_partition(struct blk_desc *desc, const char *const name,
-				  const char slot[2], ulong image_size, ulong addr)
+				  const char slot[2], ulong image_size, ulong addr,
+				  ulong *part_size)
 {
 	struct disk_partition partition;
 	char partname[PART_NAME_LEN];
@@ -396,6 +402,9 @@ static int read_slotted_partition(struct blk_desc *desc, const char *const name,
 	if (n < num_blks)
 		return log_msg_ret("part read", -EIO);
 
+	if (part_size)
+		*part_size = (ulong)partition.size * desc->blksz;
+
 	return 0;
 }
 
@@ -440,6 +449,7 @@ static int run_avb_verification(struct bootflow *bflow)
 	enum avb_boot_state boot_state;
 	char *extra_args;
 	char slot_suffix[3] = "";
+	char partname[PART_NAME_LEN];
 	bool unlocked = false;
 	int ret;
 
@@ -450,6 +460,33 @@ static int run_avb_verification(struct bootflow *bflow)
 	if (priv->slot)
 		sprintf(slot_suffix, "_%s", priv->slot);
 
+	/*
+	 * Hand libavb the buffers boot and vendor_boot were loaded into by
+	 * boot_android_normal(), so the bytes it hashes are the bytes that get
+	 * booted and the partitions are read only once. vendor_boot exists from
+	 * boot image header version 3 on.
+	 */
+	snprintf(partname, sizeof(partname), "boot%s", slot_suffix);
+	ret = avb_ops_add_preloaded(avb_ops, partname,
+				    map_sysmem(priv->boot_addr, 0),
+				    priv->boot_img_size, priv->boot_part_size);
+	if (ret) {
+		ret = log_msg_ret("avb preload boot", ret);
+		goto out;
+	}
+	if (priv->header_version >= 3) {
+		snprintf(partname, sizeof(partname), "vendor_boot%s",
+			 slot_suffix);
+		ret = avb_ops_add_preloaded(avb_ops, partname,
+					    map_sysmem(priv->vendor_boot_addr, 0),
+					    priv->vendor_boot_img_size,
+					    priv->vendor_boot_part_size);
+		if (ret) {
+			ret = log_msg_ret("avb preload vendor_boot", ret);
+			goto out;
+		}
+	}
+
 	ret = avb_ops->read_is_device_unlocked(avb_ops, &unlocked);
 	if (ret != AVB_IO_RESULT_OK) {
 		ret = log_msg_ret("avb lock", -EIO);
@@ -566,6 +603,26 @@ static int boot_android_normal(struct bootflow *bflow)
 	ulong loadaddr = env_get_hex("loadaddr", 0);
 	ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);
 
+	/*
+	 * Load the images first and verify them in place: libavb hashes these
+	 * buffers (see run_avb_verification()), so a storage device that
+	 * returns different data on a second read cannot slip past the check.
+	 */
+	ret = read_slotted_partition(desc, "boot", priv->slot, priv->boot_img_size,
+				     loadaddr, &priv->boot_part_size);
+	if (ret < 0)
+		return log_msg_ret("read boot", ret);
+	priv->boot_addr = loadaddr;
+
+	if (priv->header_version >= 3) {
+		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
+					     priv->vendor_boot_img_size, vloadaddr,
+					     &priv->vendor_boot_part_size);
+		if (ret < 0)
+			return log_msg_ret("read vendor_boot", ret);
+		priv->vendor_boot_addr = vloadaddr;
+	}
+
 	ret = run_avb_verification(bflow);
 	if (ret < 0)
 		return log_msg_ret("avb", ret);
@@ -575,18 +632,8 @@ static int boot_android_normal(struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("read slot", ret);
 
-	ret = read_slotted_partition(desc, "boot", priv->slot, priv->boot_img_size,
-				     loadaddr);
-	if (ret < 0)
-		return log_msg_ret("read boot", ret);
-
-	if (priv->header_version >= 3) {
-		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
-					     priv->vendor_boot_img_size, vloadaddr);
-		if (ret < 0)
-			return log_msg_ret("read vendor_boot", ret);
+	if (priv->header_version >= 3)
 		set_avendor_bootimg_addr(vloadaddr);
-	}
 	set_abootimg_addr(loadaddr);
 
 	if (priv->slot)
diff --git a/common/avb_verify.c b/common/avb_verify.c
index 7b60be4da7a..92f4f82df48 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -1103,6 +1103,84 @@ AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked)
 }
 #endif
 
+/**
+ * get_preloaded_partition() - hand libavb a partition the caller loaded
+ *
+ * Without this callback libavb reads every requested partition into its own
+ * buffer, hashes that copy and frees it, and the bootloader then reads the
+ * partition a second time to boot it: the verified bytes and the booted bytes
+ * are different reads of the storage device. Serving the caller's buffer makes
+ * libavb hash the memory that is booted afterwards.
+ *
+ * The boot image header may describe fewer bytes than the hash descriptor
+ * covers; the missing tail is then read into the same buffer, up to its
+ * capacity, before it is handed out.
+ */
+static AvbIOResult get_preloaded_partition(AvbOps *ops, const char *partition,
+					   size_t num_bytes, u8 **out_pointer,
+					   size_t *out_num_bytes_preloaded)
+{
+	struct AvbOpsData *ops_data = ops->user_data;
+	struct avb_preloaded *p = NULL;
+	size_t num_read = 0;
+	AvbIOResult rc;
+	int i;
+
+	*out_pointer = NULL;
+	*out_num_bytes_preloaded = 0;
+
+	for (i = 0; i < ops_data->num_preloaded; i++) {
+		if (!strcmp(ops_data->preloaded[i].name, partition)) {
+			p = &ops_data->preloaded[i];
+			break;
+		}
+	}
+	if (!p)
+		return AVB_IO_RESULT_OK; /* not preloaded, libavb reads it */
+
+	if (num_bytes > p->max_size) {
+		printf("%s: %s: %zu bytes to verify, buffer holds %zu\n",
+		       __func__, partition, num_bytes, p->max_size);
+		return AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE;
+	}
+
+	if (num_bytes > p->size) {
+		rc = read_from_partition(ops, partition, p->size,
+					 num_bytes - p->size,
+					 (u8 *)p->addr + p->size, &num_read);
+		if (rc != AVB_IO_RESULT_OK)
+			return rc;
+		if (num_read != num_bytes - p->size)
+			return AVB_IO_RESULT_ERROR_IO;
+		p->size = num_bytes;
+	}
+
+	*out_pointer = p->addr;
+	*out_num_bytes_preloaded = num_bytes;
+
+	return AVB_IO_RESULT_OK;
+}
+
+int avb_ops_add_preloaded(AvbOps *ops, const char *partition, void *addr,
+			  size_t size, size_t max_size)
+{
+	struct AvbOpsData *ops_data = ops->user_data;
+	struct avb_preloaded *p;
+
+	if (ops_data->num_preloaded >= AVB_MAX_PRELOADED)
+		return -ENOSPC;
+	if (strlen(partition) >= sizeof(p->name) || size > max_size)
+		return -EINVAL;
+
+	p = &ops_data->preloaded[ops_data->num_preloaded++];
+	strcpy(p->name, partition);
+	p->addr = addr;
+	p->size = size;
+	p->max_size = max_size;
+
+	return 0;
+}
+
 /**
  * ============================================================================
  * AVB root key digest providers (selected via CONFIG_AVB_ROOT_KEY_*)
@@ -1170,6 +1248,7 @@ AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num)
 	ops_data->ops.user_data = ops_data;
 
 	ops_data->ops.read_from_partition = read_from_partition;
+	ops_data->ops.get_preloaded_partition = get_preloaded_partition;
 	ops_data->ops.write_to_partition = write_to_partition;
 	ops_data->ops.validate_vbmeta_public_key = validate_vbmeta_public_key;
 	ops_data->ops.read_rollback_index = read_rollback_index;
diff --git a/include/avb_verify.h b/include/avb_verify.h
index e89bb229e02..2b5b24958ae 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -23,6 +23,26 @@ enum avb_boot_state {
 	AVB_RED,
 };
 
+#define AVB_MAX_PRELOADED	4
+
+/**
+ * struct avb_preloaded - a partition already loaded into memory by the caller
+ *
+ * libavb hashes the preloaded bytes instead of reading the partition again,
+ * so what gets verified is exactly what the bootloader goes on to boot.
+ *
+ * @name: partition name including the slot suffix, e.g. "boot_a"
+ * @addr: start of the buffer holding the partition data
+ * @size: number of bytes loaded so far
+ * @max_size: capacity of the buffer (at most the partition size)
+ */
+struct avb_preloaded {
+	char name[32];
+	void *addr;
+	size_t size;
+	size_t max_size;
+};
+
 struct AvbOpsData {
 	struct AvbOps ops;
 	enum uclass_id uclass_id;
@@ -32,6 +52,8 @@ struct AvbOpsData {
 	struct udevice *tee;
 	u32 session;
 #endif
+	struct avb_preloaded preloaded[AVB_MAX_PRELOADED];
+	int num_preloaded;
 };
 
 struct avb_blk_part {
@@ -45,6 +67,20 @@ enum avb_io_type {
 };
 
 AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num);
+
+/**
+ * avb_ops_add_preloaded() - register a partition that is already in memory
+ *
+ * @ops: AvbOps from avb_ops_alloc()
+ * @partition: partition name including the slot suffix, e.g. "boot_a"
+ * @addr: buffer holding the first @size bytes of the partition
+ * @size: bytes loaded in @addr
+ * @max_size: capacity of @addr; a hash descriptor covering more than this
+ *	fails verification instead of overflowing the buffer
+ * Return: 0 on success, -ENOSPC when no slot is left, -EINVAL on a bad name
+ */
+int avb_ops_add_preloaded(AvbOps *ops, const char *partition, void *addr,
+			  size_t size, size_t max_size);
 #ifdef CONFIG_OPTEE_TA_AVB
 AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked);
 #endif

-- 
2.53.0

