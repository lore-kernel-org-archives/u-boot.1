Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6ECBC61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:47:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CB8180CD4;
	Tue, 25 Aug 2026 19:47:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c5Gl0MOZSJW8; Tue, 25 Aug 2026 19:47:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787687267;
	bh=vH0GiJAmlf8EcHmN+CJG7vdEQjJSF4VJFF0rYao/FGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KTTTaI/kf4pdFiNu/QVdmXYxPIuZjRTtMIIj6jexpcW8SkY/kJeE718Z3IJkTqkcn
	 5+kUigJ+qQOOJA8ODEbBKR2wiierhf+8Z7PMiJiLbgaofYAYiJjIcD9g5ywFufcMTA
	 S5OoanY2wcp3XO0ob0+1acbK1ckqZoG6y4YZddzSq2mN74ZeGzu/f3AyrbzYLYUOZr
	 MtLjqJQm0dDKY5mtxhWnPJzbzHXtcqW5Guqx0I3XGtvK6qwARWGFNrAB/abUr8vzUc
	 GYeHqFkTbYMW6mntssu+vJQoBF4L87K2BeA3eD5FOEwzxwTOT/QH3z8xT+BqOrNxT9
	 UKBBw13kVXgLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4922280C79;
	Tue, 25 Aug 2026 19:47:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B2490334
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:47:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A425C40055
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:47:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fPw49ukTXpnr for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:47:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=lco2+1OZ
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BAD3D400A8
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:47:44 +0000 (UTC)
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-51c4436d02cso1372231cf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787687263; x=1788292063;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vH0GiJAmlf8EcHmN+CJG7vdEQjJSF4VJFF0rYao/FGU=;
 b=lco2+1OZRVhc+Dsqhqg+7DUJE44Q+ZHHr+QOQVNRnvEcdJiYJGWPMVu+xqmPbFPUkz
 cceXR/MqK/wzMX+WrQjkkZrYOe19UDEuxEhscdkgkElR3L8TjMlnIBsUQLVjt6RIAw98
 CBADXAREiwiSgN02aGcZtf0wg/DhiDDJKnHRYLmdkmMkaOcSYBSg2YPG+6l4cBzA91hY
 LZcyR5Qz073AU0uB3DC9VypQ+UC4ls4oPWbMEQ5Rs/vf9ySV6KF9VcMzJ5Wz1j9UQqUP
 VQzDObL+W2MCJRMcIPuYaoDrYuug2KD59S0P8ucliWqz2rOe3Jd0SBSz9rrJEVu7Itsx
 7/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787687263; x=1788292063;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vH0GiJAmlf8EcHmN+CJG7vdEQjJSF4VJFF0rYao/FGU=;
 b=BjdxlhQKwP7GYfhIAGS01PuvskmcJ97RBJIJ2D0Jpmkys1VweAJxsbG192Kf24oODi
 iGJU7bRpSIs8nM6+nblLQQ86JRS39W0GLdqdRPbUznSt4RHT66HvPPILkk1fgxidrG0/
 if8FcQ1V4uvMPzoz6BiUJwT13SV+9boavdDS2+0tFKCOi0OgIVXGMA9D0vUm+bu7gY2y
 IRD0o3+LvvyGo29PK2R1PALT49onplkevKSqxbVQEZ79ZEzlpt4AWlZbHxGtDp8MEcjc
 wAcV225i/yKFmmHxZq3W7JBbqBveetAsF6fDQBiQZWd6ioVz/qyHEqZZaJzyPnA1ICuk
 Ot+A==
X-Gm-Message-State: AFuF++mF+dviPlC2qnfzVxwKv3w2uSBQgH8DPscxTpR/WW2q8XAq3jsb
 LTyb5YVGR9SLdZgf09fgreFVAIOjnXeAvlQ2QrgpmxlAn6N1eIam1eHDvbXXws/3T2I=
X-Gm-Gg: AR+sD10s0/IKhTTOrR735Q4Br0RzIB+13+2gka9ngO7eoJD3x4jlhbWYMoSYNApeUKx
 azGbQL/6G0JuohJFbr6q46p+9X2Xl92TyCqHvQc0PPcCydOgRecMa0lxhJduZy0bW+JGLbA8gFP
 7+xUhVsGJ9D4TWN6l5SrhvfoI2tTcVDxpudjJJqgFHx9c/w7zIITrz6leYJzVb6aQONATyAcpJf
 WLqkSHkcyoB5XWbIsTeVi4aa2hohGuW3NocelAL0IaxdcIlrBsItz/k2p/OHAhmatD0goCxzTM8
 SWUlRhAFIoKg8NRdC1cWZqzqvs1Pfv7T/yJKHmnSqP5KcBhnWwyvgfMiWVrZ7pk12LLzsH8u9he
 3ywyP7pVl28wGXJGkgi1mYv9IsvLBcOA2qsG7caatp/HYaUO2PISlui4dr3UyTTNpqptnYupnVR
 ZkesBj7kTJKvBaA+Yp/tsupFhvUMRnmpU+kETKt/IsIFqzF586Z/HgNDofUZlEl2TKe/p5mQZLs
 8A0mld5eXJeku/sC+Z4UylutVcswuQNaCC4hR5elFE=
X-Received: by 2002:ac8:7e8d:0:b0:52d:918b:92e2 with SMTP id
 d75a77b69052e-52e4222c9c4mr15439441cf.6.1787687262783; 
 Tue, 25 Aug 2026 12:47:42 -0700 (PDT)
Received: from localhost ([66.129.139.8]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cc65448f5sm6175566d6.45.2026.08.25.12.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 12:47:42 -0700 (PDT)
Date: Tue, 25 Aug 2026 15:47:41 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v2] mmc: zynq_sdhci: support Renesas RZ/N1
Message-ID: <ao3xXc7dNbFmKEha@maple.netwinder.org>
References: <20260814-rzn1-2026-10-mmc-v2-1-51e4d8a717b8@linaro.org>
 <4e3a48d8-d971-402f-9542-820f254abc77@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4e3a48d8-d971-402f-9542-820f254abc77@mailbox.org>
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

On Sat, Aug 15, 2026 at 12:21:11AM +0200, Marek Vasut wrote:
>On 8/14/26 8:30 PM, Ralph Siemsen wrote:
>
>[...]
>
>>+++ b/drivers/mmc/zynq_sdhci.c
>
>[...]
>
>>@@ -1152,13 +1177,13 @@ static int arasan_sdhci_probe(struct udevice *dev)
>>  		}
>>  	}
>>-	ret = clk_get_by_index(dev, 0, &clk);
>>+	ret = clk_get_bulk(dev, &clks);
>>  	if (ret < 0) {
>>-		dev_err(dev, "failed to get clock\n");
>>+		dev_err(dev, "failed to get clock(s)\n");
>
>"failed to get clock(s) (%d)\n", ret);
>
>Please fix globally.

Will do in v3. I'll just do the clock-related debug prints, since I am 
modifying them already.

There are other (non-clock) debug prints that could benefit from same 
treatment, but that would be better done as a separate cleanup patch.

>>  		return ret;
>>  	}
>>-	clock = clk_get_rate(&clk);
>>+	clock = clk_get_rate(&clks.clks[0]);
>
>Can the clock ever be non-first clock , i.e. do you need to handle 
>clock-names DT property somehow ?

It's not clear to me if the DT binding specifies the order. It says 
there must be either 2 or 3 clocks, as well as clock-names properties.

Existing DTS files (rzn1 and zynqmp) have it as the first clock.

We could try using the name ("clk_xin") and if that fails, fall back on 
using the first clock.

Regards,
Ralph
