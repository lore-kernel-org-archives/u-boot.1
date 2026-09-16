Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B6BC982C9
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 19:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 214364066E;
	Wed, 16 Sep 2026 19:50:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sHk5ND6RcbnT; Wed, 16 Sep 2026 19:50:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 777B2404F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789588252;
	b=RVxrgcSfOy3lC33VaQd0LHeL7QJi/sABSrXeQyfhiDJqjwjyRGdTRykXKn7zXIaJ8f/g
	 QrLur2qv+F+voxBcXzyLDzUih3r27zJjEZ4zJ7CCXPidQMsLPRG8bevZu6LbPjisem44p
	 qYOC/rlY7QXv14uyz51lZgNdJNNR87rYk5tj2VvepcoopBqFVpTMmTUZoR8Gwf3FZcD64
	 +D05JsHOOZzGeESxLd12kUPEptV+eK8F254TqZSe4366+i89n/2R+8cTaNpkVOndAdUNq
	 ykd1RUQounskfFmdkfpFmEWRjsi6sh+SBJcA6NvoeOTgBcO4yL4Vz+mgnh6vHRhVIGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789588252;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=iOdCusvzL53g9ZklBFVNytscUotCuJ4zyG5gPKUTdeA=;
	b=KUaCdbmor3hbfJ9a3eorgwupl04e+/9N3Edw3W15vzQ81n3yzaZ8uQniV9UTICjwzqci
	 OCCfwcFE/k/GxnesSSge3V91CGzSobyVHN7LzWGnKDwNBBA/T2Hq2KjO+fQcMfe51g6Go
	 df8qDTuF3h331qVIgVL091up/FmFH1IsOJqwhGH8FvMPjDdzoEBvhlqzvSuDRfVkMOw2b
	 l/sECY3y14AOsGt6Qn2vd5GjKsvqrWsvoqbNzd8dZX03/nSYpLjPLvQfHiT/glYh32djF
	 shw9cKZcBkKliA8cItDRYCbBvfTNo/kLljs+nrCFC/WV/HVf04juNbeJ4qb2VAyi5mw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789588252;
	bh=iOdCusvzL53g9ZklBFVNytscUotCuJ4zyG5gPKUTdeA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gw7udevdwFW+I3BHBNopWRSKuMSwhi2BybvomSBfaV0ZDvyvK+IcuT4KlTvriUGf3
	 omCSgD25TZGAE3zyTgo+FxmKJe9zeFQZxivUI72U3pa9LNClG+8IryFMwaGY7J/PZO
	 4j6tuEKZXDyPQmSiLe7z6wzENrWcGWWgQleAKcyccJyn53T6pv3xw3/jD1nw9bm+OG
	 ZqArNflqYbkCvuNacOc94tDEOE2i9eOYtcFNIPeTT9o32iN+aV5HjGWNt1reX0S3u8
	 XVh1weozWhneFZB+4G/PVWBOX6cxv+Jr73KNvdzrq419OSztpy/JFyIHSRWC18JVOP
	 3TTBu5glqK4RQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 777B2404F9;
	Wed, 16 Sep 2026 19:50:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E17942D
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 19:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3FEA06061B
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 19:50:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VDfzJUeqqYcm for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 19:50:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8A08260618
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789588250;
 b=gfFkFIF82z3k3zk/K8S2RXEaggaRBK6H1GjypC8fOlhZEaIKweift2lokzgNkuwIBgC6
 2ojVhdNBUfdfYQVzG+nOgjQ5ah0FZjoSCEmUTiAEDrgvlUWOjtpLvScir+3FiazCp3TuT
 mo/hrePWidavqlKJywp4mNgTOUennSFEH7v+ym7AxLdb2ldxZAcSHDolO3thGG6t1wzcx
 TacP4eopvctpulCq7yFavWa4pm2PB0od7B0TIcUlM6ZCUZbY+ZCLUl7Vht2ME3Fo+d8Xg
 bT3xTXZPyIJWtFw5aoOVY8aVrOWteg3zVHIpwxKn7NLw36PDTvTCRpDx0G+xJhhrsyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789588250;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=iOdCusvzL53g9ZklBFVNytscUotCuJ4zyG5gPKUTdeA=;
 b=UGLMojdQwnsXpC2Ge5PqgWUtzvJduJWZF1qjRNP40J7JQD4PTJyyBsUDuNove+oNFvQE
 8Y+4bfjhkCd35efhxg4lYrk5Gio0Qfm6GvtrfJsbI9zr0FZEoysuo8qinFVECoQAsOpmS
 6btKjSooTV/Qb4VRNrxC58XvuGKWrQ/s5+imfuuYbEK+C6x9SbMSlvdTEEmpJHKDBsyEl
 P6wcRWpdfe8pB+XV/dWdsfjVnv7t3H5ZOkufnz/7Exlop6bzrsku+PD7SP9+cvwlfx2xY
 O+WZXv++NJERG/fy4pJ5AJ0ks5VAj1r9mzFZFHbJDqf04AJ/b0w8m5cZy7kvWtP7N4w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=oL3T9UZJ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::d;
 helo=mail-oo2-x0d.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=oL3T9UZJ
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com
 [IPv6:2607:f8b0:4864:31::d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A08260618
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 19:50:49 +0000 (UTC)
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae6b1b26so7192eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789588248; x=1790193048;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iOdCusvzL53g9ZklBFVNytscUotCuJ4zyG5gPKUTdeA=;
 b=oL3T9UZJ3jdzq6WxCC9kar6hUZ7JlQc9vsZkGSgsARA7WmgAM5w48a2EuKb7NFK4gg
 Tbm4bwBnFBvaP3taNCAeJPOUYOVCxfwI64C8bJRX93GMg+GGo/Jr5Y5p/HyDeO7ILuCE
 /fk5FaxsI35tVgELnOOU326kdkisVUDr4riTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789588248; x=1790193048;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iOdCusvzL53g9ZklBFVNytscUotCuJ4zyG5gPKUTdeA=;
 b=V2mDlCUU/OSgUVkANohIeLFROs6w0jmPnnBfJzffsfxlDE15ug5xHMg3S2kh3g0UbL
 Wy86oeJusbDjJmuWzT9q4YAMBEZ+c7/7uMfyT+FckcQ1xRRB1tUCb91dlPWdbQHBQ8TZ
 6MhR+02OsEIPDYzWyddtOEy/WbtPNQ2bJZlVwCGkXP4cKu3U/HwIMuszg747CTXzvEuA
 DbIKXE3wKfbORNrW+1gaGtiSHlzsvTgjTUlneLWfHu5ejlWdOvMmoFbabRFaCsFEkTI0
 cu6dvQgjxaUYQKEF724UKvaBvRAw503fKLEt1X65VYqSj2c5v9js219I8ZJ0k2lTVh6S
 y8Vw==
X-Gm-Message-State: AFuF++klot0HxJCX+qx/qqbryXxDBxCZrZX66epHNeml8hz0KhYwYIJR
 qCpZwTg37UIl7ngzT5g/sOZE80tZuJ/Ie1Nw/fywFhri0oHg8agy8d+mlBo8FP31a80=
X-Gm-Gg: AYBFou2occCATEXh+dsFAGDU2ZjtHOLs+Y3oAlxxaukp+hmDIxhI2Fu+1npDLBMebuY
 wGR6M24K9ECTbkQjkPHu2oOLCVvg/EjOtVf9aayKiNOcaULAJaURI0SlJdl/yLZp9rSdB27sXtN
 jZ5RQ1EVSOey3YqxDM0+0BgfBUSP8vgkBYfuI23UpttQetvEvlsKEGDy8V3KblqrhuvMR4i1DZf
 UguGHTBVsArYA9B27dKXFBkDKm/I1fwNKhmng6oxW94O+AI538y9HWUdFEs6tPXLQ4lFi6Nu+uv
 uSG3shSd3we5EqRFuKFuLCxCJkQddXh1ZQzLKPIFJpLvH08thgiDgkfHi2pupC6PX6u6isoT8ec
 /yCDj1txOUIeiuMBUyOSUGeJvtcCqTns7tG/+hM4N4mURcno/BArXmvlnZk1yvcyKFWuK2bqV/N
 QVZISXE2puLOjoZfGT82q5loIWrBjhMmGsVb4ZRDuioyvywKfbnYI5v7YvoEl7MzR0M+TFY7oq3
 hRWhthO1lgA8SXZpiwm9lfdgG4YmCkUP6KNMYlyhJ1UaZFb8G/tmkU54k8ZamdzMQXrR6Dm91NH
 hcR2a4QNtl2NsaJq0FA=
X-Received: by 2002:a05:6820:2087:b0:6c1:c628:b0bf with SMTP id
 006d021491bc7-6c7d15cebcfmr4327748eaf.13.1789588248025; 
 Wed, 16 Sep 2026 12:50:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4842a788040sm3315015fac.17.2026.09.16.12.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 12:50:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@nabladev.com>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
In-Reply-To: <xhkdb8q511w4w.fsf@mkorpers-koolstof.csb>
References: <xhkdb8q511w4w.fsf@mkorpers-koolstof.csb>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20260914 into main
Message-Id: <178958824683.1223224.8621708353458839997.b4-ty@konsulko.com>
Date: Wed, 16 Sep 2026 13:50:46 -0600
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

On Wed, 16 Sep 2026 09:41:03 +0200, Mattijs Korpershoek wrote:

> Here is a PR for main with the following fixes:
> 
> Android:
> * avb: fix missing break in avb_set_state() switch
> 
> DFU:
> * dfu: mtd: probe before get_mtd_device_nm()
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


