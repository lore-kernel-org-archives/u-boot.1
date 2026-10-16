Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAAFCC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 16:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0370060B45;
	Fri, 16 Oct 2026 16:50:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JWgtGzOIkIQp; Fri, 16 Oct 2026 16:50:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 25BB760AC6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792169428;
	b=LtF5Cyw2L9wyCSQ9i9NpBYm9Vz64gihl0gnjEZm176+W1p16IZwdeoKGRLZ9choMYgT1
	 i+ls1NFuvic431rthW9Aot8xH5VdtbomcCLBekmG5LpL2HQx49cEidQrbHEabZN3FHtkD
	 UKFf5z8WSNYhmS4T/Tfzd8SihCbZWWq+0ho70PUEuFS5CHVqtFCRsoJLuvAyqgQ8Tpg6f
	 98asfM/HIC4TZ/GB1QEds6dk57J0/SKtrd/6IhFtnygUCJjfh+vlIWlVlva0dxIjHhuAe
	 oM3VxSJPYH6ntj9MrdP2IWOxBPGlg1D+9r5X+nMZKmQALIYS+rgAaFtdUL4IMFicE5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792169428;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ZsMsZK2R3lk+hteS9EOobbBt7wHTEHlGwBmjalFesa4=;
	b=OqZPSpHC2uQP2koj444xQovcPrklBTVxMTSCFA79ubT0aWQ01rYTqtn7baiY2Nl5CcpM
	 mR6CZEmrJUCRJz0Y9Q5ieKlf5vtuSzvjGipnsiQwzcPqssHQtLSq+jemJxN2gGSUZhk3/
	 ytzkRcwv34jZN30jnKu/HfcJTjG6f+1yyUdg0uBmjFtzill1VdPF7/GbNDfaF1fU7gkQ2
	 hMT3j9YP8+QEobYWU4vpThl8Q/GxNaB3WDdtobj/FjZMnOVT9WfUAL+iSTulCPqX7Oaw8
	 BKLMtO4omlQR4lEsfKIvouXSUKlifw9AVOUu2RVZWZLFpsVyTgjg0qRzlD6Ndrm9hyw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792169428;
	bh=ZsMsZK2R3lk+hteS9EOobbBt7wHTEHlGwBmjalFesa4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AtEOPc6LSfm9kfYaIhIdBaoH9hRRQRrq1GsUZPR6kcPxf0QG1/3kZB/eavpLKJmOk
	 /zp9U0ntfOJFu/d2oqksdAKtkxG2Y0A13pxISB7VZbmJOf8HGLVyVTS0/qcEY1azPt
	 o3nZVSP5Oj0aILE7oW/p1KjSlKz4Y9CEZaNEvupQ8goqEtfoa+U09clKroQ5CwVDxQ
	 xcFdflwCz/cYEEKhF1HeHyRlF0RaidYCJMHRnGl97VrN/PFACdFaHhG4War1E5e+ak
	 OKx7LW3rricR2BLYkfUxWBWhQdO96c7698/2uy/Z8IbbhSNsaSGEaq2LLBo6d/+TF+
	 1tcn0LqUlmBLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25BB760AC6;
	Fri, 16 Oct 2026 16:50:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7EFA7255
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 16:50:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 70DF840ACC
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 16:50:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f8mRicVRLMTV for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 16:50:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 86BE040AA2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::342"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792169425;
 b=kY79+u9KI43jAkmahwxRKP8DIXvtg7LQ8OuU1g4JIaK58Wq4OCj1HBmywc7lbg8OqEwT
 HboeVVYjNuGoRgGty1ALX0LxQFVe+UW6dQAMl/39ODAmr2i5J3p05keWsLAQFpD1ft+FU
 aLJ9K54cDHIuM81B1UW6s3UwPJ5QdAj17rWLOXR8+Joii0ig1E+HGPqYhiZ51s1PjJEt8
 OPtTFpkM3D6bN4wuGSj1ALrO4IsLzIB0ipAXgkXqxgXVIt2/qwO3E+ZADu/BrCeSIp/rW
 NWzKE8J88qy8cer1aLiyGWjE8x7d9fgCA+NJVMegnFmIUdZMJze0LMmM+4jdE0SE1Fw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792169425;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=ZsMsZK2R3lk+hteS9EOobbBt7wHTEHlGwBmjalFesa4=;
 b=LQf8eWs1n5CH5BZTdURaYcHHkRFmxHtkRp+QWf12Ip2jpPq7Sbvr4rViKktYAoQh0jqT
 8I7+r/wm3TP0MjqN93xs9Gafc9Zm5H3z+yRlNGfUwxILwbVbcTeooSE65rvhfapeuIAVz
 ARp63scOjQmDaAR1Au0i6EgqFtf/yLSZnjL/jAtLBsoUvSnaoAuOcUr2m03UhVapg07T4
 Az0R5uMuF8fOg52jFb0R/vaMv7OFkEKBQxmZbNSQm1nVQvG/pWDp8eJW9qZyXMA4KZwny
 WMXIiAGx2wHrBYBIzN/DonO7iHRPoN2eTr3DmpwWncfdL7nY/HizIsF0RMz/4hRcGjA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LxQc6ZnO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::342"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LxQc6ZnO
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 86BE040AA2
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 16:50:25 +0000 (UTC)
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-82374c2d7aeso152326a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792169424; x=1792774224;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZsMsZK2R3lk+hteS9EOobbBt7wHTEHlGwBmjalFesa4=;
 b=LxQc6ZnO3Ohp16l2xLgqQ6NkRZexUlGR62m+ktSu6xmris0VO4GEWeqXvArss0mf7N
 off5RM8bzz9Xy1fI5GUPM2PP59FVlJ24u+kqxeCzROz+geMPtL/w3vdVaF71rjmS8McK
 495wl5PJlNpwtdNyAbNhZNbnKdKBfDapPidXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792169424; x=1792774224;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZsMsZK2R3lk+hteS9EOobbBt7wHTEHlGwBmjalFesa4=;
 b=zn3AvpCgRg8TymG0hIEpLyYlDPH1dfnCsOmRx2d5fYdzX5Wq4GNu7rBvHlVnJhS76V
 /OASPUmgJbzKwTYfGSvmp/RoSdzf68ADXaUQmO2mKRxGXpxJDy1IOFPvIId4eYEpuILp
 thvLfgMuVFwrNb+TFfxqoZ8VglbapkGkg8sgx2mCAbScHlgLV2c7gTzdsrd6UDGQGT4B
 Re7lvWOgVB6Z1mWcsRl1MuhoHxlwrk/JI9KGOvUJft0L0z/OeKSFPnQX3fIzA2XFoXYC
 gvtw4FL8y4o2qEuPpFmIS2WM5NxzJ5mrx2D1g8HEpX2TNyzXGrmC/6d8wTPdic8j3Ajk
 rt7Q==
X-Gm-Message-State: AFq9FYJZdgTIxCtVoM2xkU/FYQecGWSEkcRFSh6x3xhmaq72g9NLEmOz
 +mzhDoqLsoOc6JR7MTO6hP5UG4dzM0JU1cXNuYGPbnnib/xAj8KCD/R115F6ftbU9NpyyC1uVX2
 ZJSUjbfw7gO4xMvc=
X-Gm-Gg: AYBFou2t/RgaVnGjothAnzfBx+xT+ATH8/8wGBaffdyWhH7ylnPm/xdAb/LOU7vFc1t
 ZSrGFxir4jzyuSHFrbpmHli73bSDxqfIkP4nBeiPxf2izYjCVLn+HK1wnoUCBhRRqQBjfEYCs2v
 SfL17YI6BpYgo1gKEcf3MzMR5ogerlcZeQj2c9A+KXY9l+oY7zJy97m2w7yI3bkhcvuzfps1haJ
 +xZZnc1GrXp+rGzjYVCByR1n4GBSP3kHXfI4wGWKQKr1uEqIr1tQkRjtnNJjG+Ud4hUK5nOOEaZ
 ftUaOICuAhBhTW/xXueeQL+utvFEMogtnF67F7asRI0g5VqlmIVhmkETsEPfBvSSkiotnhqG1LC
 PzJl90fQedLuT9RA7N8g1dnj5zZwSFaqYvrGlnolC8TEkkjfa3PKeBc2yvqQuK/RCKPBXBnKrJ0
 rV9Weo3YMt3y/h/cRzdFTR+KewakMXbWvASJ9SuVjX4XgCG9/vRuipvjbDxwDIQw8xIU2b8+pW0
 cdxoGweDGXgUYQRTA4V3p/7c1WLh9PESWknJGUM7ahpHivBZXm0ydfw3wmiX9JIX4OArIlgg2p/
 8GRFFqHrBBykX0IOzg==
X-Received: by 2002:a05:6830:60c9:20b0:829:f66:4cd3 with SMTP id
 46e09a7af769-841f9ed1144mr1979678a34.5.1792169424221; 
 Fri, 16 Oct 2026 09:50:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-842a111dda4sm2236959a34.1.2026.10.16.09.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:50:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <e15868fd-e789-4a55-8237-f27b348aa009@amd.com>
References: <e15868fd-e789-4a55-8237-f27b348aa009@amd.com>
Subject: Re: [GIT PULL] amd/xilinx/fpga patches for v2027.01-rc1 - v2
Message-Id: <179216942367.4016577.16205935596229308992.b4-ty@konsulko.com>
Date: Fri, 16 Oct 2026 10:50:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 16 Oct 2026 15:50:22 +0200, Michal Simek wrote:

> please pull these changes to your tree.
> I have extended run for 4h via top patch and CI looks good.
> https://git.u-boot-project.org/u-boot/custodians/u-boot-amd/-/pipelines/1572
> 
> We are continuing to clean firmware interface to be prepare on SCMI adoption.
> Also fixing some issues which were reported internally.
> 
> Thanks,
> Michal
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


