Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37637CA600B
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 12:46:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C9D48123F;
	Thu,  8 Oct 2026 12:46:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NZr0uo2PwxNu; Thu,  8 Oct 2026 12:46:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 25FB4812AF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791463587;
	b=hb2ANkty3CLElRxqpMz4jh0iXr/67HaRUw3RBnWqneb0HQ2R533jhnS5Ra3hCZZz67Af
	 lIOvd9SYqCU3Zuz1AG9GYXGDDTte5X60Y70thniP1B6G8YLHj93mwQvL3c9ZuolLe+R0F
	 M/m2WOh2kSv+YBOdrI4va3ORs2tDx3pAHLnUnUU/QMrFtufFI3cQ8a4Q+EH6m2j0a440c
	 Kpqz/3k5XA5goY3iMlAuxZxOLpRK6fsI4dZ+7tu8Op4pcTw/0NCP+pfbz/rurTS62qavm
	 bsRXcbLYpFUUhOdyaQ87QIKFJNVeMECaX6PPycJoaZgQbi9TZE5sfnF+lOeVP075eUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791463587;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=m2DYDcyD3iuTeZZpAR3lJYMkmDOPAmfxwTJe4niqzlg=;
	b=SHX9CsBj2CUvNfm+P0FZGqOPHijnBkCeWqJF/LPpl/BPEZ4IdIJ2T/dhMEV+CkK4TmCg
	 2+fdzNrsJwN26QoXzH15TntgExw10cg6TmyD5sN85EaNoGwNnOBIDkodz9cV1kdp+H3cs
	 bwgcuOOdyTea3AbiSpkeFmGmsJjrtf/x1+qdgfHySA7yQoO90aTp3rarJaVsKf9jNuPbY
	 pHIlKQy3gOjmL4HlJYJj/3Hhd+b+Bw7tOxQALnDG2mas5MEFgZPUqrqyNxeRHl1r4e76h
	 ICfxD6d0qM6kUEat1mCEnRdSqvoihm4XEvT8eRtDuQxJ+Jrj/B8O2G7GchAtxgkKpPA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vcC1s6aP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791463587;
	bh=m2DYDcyD3iuTeZZpAR3lJYMkmDOPAmfxwTJe4niqzlg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nyNalKoVktGQSZLXab7wC70+Ocpciv5UZ2CfpCEZ2kIs1WA6V+emjyvJj+f+gbxFO
	 kxdimgjOzCGCflN8lyKW3LwYWRtKddoLtLXsOEXS7YaG3rMJXz4hNj6qgHA3C3F3Cb
	 cSxK2bebSIGpo8sR7LnnB+mToQM+UredKYOtda2WkZ+aUeFqgaj5D5FAR/LqfzuQfF
	 ctYwg+9QhVbt0C2H/tgo28FuRB6FD8w8PRW2Pe5oWgUIwWnxlNfw+xuaFJOaih0d6o
	 5u19LV0XxPznBpgeqGFc7Sbks9hibyLHb864FapEmXgTmUWd/O3akgXxWLCEss4hCK
	 jd24kvmAL0Qkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25FB4812AF;
	Thu,  8 Oct 2026 12:46:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BE78322F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A4D5E8124D
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JKi88_19apgK for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 12:46:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 69B1B81285
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791463581;
 b=eMzl0pY3nlR2RWwetlwstBrYSicK3DwEK5DUfzQ6wH90TXmd+hF/QKJ8u9K0ocebpUcE
 XwvshnkYBpJJ59jeJ3TkRvyXxinw84LernQ56PVub0Y9SA+RwhDE3uFI6Gvn4ZFhQqhD/
 Y5Siy8J3WUMMMDl3ZZ0No80EdclMZHbUuTWX/i1yIMzdrg3MeuCSh6bjiQqlhaAr5AWJ/
 qk1XTbLZWYJ3o945MrkGuUbgM91yusHvwq1+aiQqVZaIQgqRU54nGrG49GwGUVnWmQB/E
 aCuzwRZJzmQ49NrCU9e7Gns2WwNQMSU6U/OeaNGcZhUvry6gccOEX0kjCEeK13ljySw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791463581;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=m2DYDcyD3iuTeZZpAR3lJYMkmDOPAmfxwTJe4niqzlg=;
 b=lBGqaFqy7wkR2cZGISe6580jlDRhCUB2vYcKmbjUDTQoe74MKYqvA9kXorKj2ESWuhV8
 nBDMGuppvGcsw2bt57EEV7C4DL9fNSiEOCBRdI7B8tHyzYfIXi/vxy+4MHDByAVGzr3KG
 pyCKkNvqwU+3lFQJqh1YUp8CtEYFcf395qb8RtK8ivrLxYHrmIEtXop+wsdjdHf2ZPfET
 sUksA0oLO/IJ63CEAc/fdlu2v4pBdlU5EKrSr1Y11czaW65W3DYAPiqXF/UpP3cL3sQUe
 6LaPB27fLlqU9+XH3hjNQyrBfgqLO5C12gmYGYNUuw/8EjY0KnUNZFuqRbIJakxAVvw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=vcC1s6aP; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=vcC1s6aP
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 69B1B81285
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 12:46:20 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a168355946so27294855e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 05:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791463579; x=1792068379;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m2DYDcyD3iuTeZZpAR3lJYMkmDOPAmfxwTJe4niqzlg=;
 b=vcC1s6aPQrl1HHwdE18VlRgvjOi9yQP4mRH4xrM/cl0xpJAGUzzI72xSDk+WAVgXYy
 9v0GDmssNYHxLQWhwHAJwgwmZ3eMRz1mUKFErlIh1gdnJ0Gfa5Pzok2aca9ZQciH/QJW
 q8DylcF5E9LQhgwoSTzJH6GFm+EjLm5KEfIJjSM3BwQTClFCM+FPc+O0+P86aMTXQmjH
 3yTgU3FQnbj7RSJmYmtYC/pqaoSvsxnV31S7lG5wdlR6clnBiFJc7qgv90gziLoOqqr2
 POH9HJzzL6bZDZ82f6DUMSCgKIagvOLNbhMLNuXiK0587Oy/bcwvCsHvrgeDWmV2nDvj
 iZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791463579; x=1792068379;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m2DYDcyD3iuTeZZpAR3lJYMkmDOPAmfxwTJe4niqzlg=;
 b=RRetUzMbGhydhWc1e8Oiq/Xzema2tR25TZ/7jAi/NvM7StVZXfXp7ewNIMMF5bDxhd
 ek1LoVx3FutwDzU5DESa/2LXjMKJ2ObOJGqbxFNKQ/d7h5A+pmb9SSNr9A8EVPweZx/2
 Vwd/ZCA6t1E+f7yZ8g+OCaNAzHnTvZ2ldtSBm4wK18IVU7FMt80nwbfi+ETbUUfKkp1v
 md28AsAAyChAt0hx4iLuMUG+4ABROyUMNbSYipN6ZkJ5TNsDTxXALN9pUmK7AeyWYXrL
 +678utY0Gs0nux0OR3RfxJQc0UDoon6B9Gfq9YPyxEqrj24OGLg9BFFTDE04eGvTnh6K
 2Ocg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxpwLxUfsFH/3ANgCWHoG8T2x/w/5UunOM5YbmOiGAccT2YGnW3EW488jBi8qCMpgwekYb298=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mmZmWv1r7ndHW5FrxSQcjdmW0Eh6R/UTJ4soqFzdhQ9F27yKRC
 OEagt9N8dNgAsWTt2x7O3imfwVPXQckI/f2tbazMFuzx24Z1MAzPeP0HoM9FHo2yZEA=
X-Gm-Gg: AYBFou2dmV5rgA/wYtRyfek2zRNvIWKrEDb2CkPtwC97GC1mZizgQH3N8gFwaRJBlF7
 R99ZIbrhmL05MeuG3IRRR+f6oQRA8CzIMjST7HxPe8DJhfuCZQc11PzSRc6N7KY/kZk1CFJ77mE
 N77Py2W4RiWhvjQPoFVpzXgRa4JeSXbLRmFhv1kt4lfm42YKa0tz5x1p4JVF10d56SicnIBsnAW
 wTXMcfeoq4FZaNVXwxPDX1WkSPSVBv3+DEoUuc3qxPpgZIp8vhJIkawVIFGHl2rICxl0+Z2yD5q
 9IBV0TdRi1kNKo2QWMYe6u19zr5rzm2C+/fnT3fCLnA+awFYSAv30iQOEF8mu0Tw5JaOUHUHemD
 aMXrDtMegHYW1jKnHv2+4khNhcKL3Gd4rq8YlhxgkivRsQfELSj1Ipzp+uvXdTI/edSG4jvfXwm
 ftRkR7aBEAbmUDMU+3YxtXvzMG8LlfayfZooGWRbv5ZZHQs/BJJPmjbaV12++oZPV08os8a6gVD
 bwZ0oARcMtLovDzcjBC
X-Received: by 2002:a05:600c:8116:b0:4a0:108:3b48 with SMTP id
 5b1f17b1804b1-4a18030428cmr95668255e9.7.1791463578630; 
 Thu, 08 Oct 2026 05:46:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d04c0fsm11015183f8f.10.2026.10.08.05.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 05:46:18 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org, 
 Guillaume La Roque <glaroque@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>
In-Reply-To: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
References: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
Subject: Re: [PATCH 0/4] configs: khadas-vim3: refresh Android support
Message-Id: <179146357781.183177.17223915816731601716.b4-ty@b4>
Date: Thu, 08 Oct 2026 14:46:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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

Hi,

On Fri, 25 Sep 2026 15:42:23 +0200, Guillaume La Roque wrote:
> Update VIM3 and VIM3L Android support to match the Android 16 AOSP
> A/B images used by these Khadas development boards. Remove the unused
> non-A/B defconfigs, increase the fastboot buffer to 512 MiB, update the
> partition layout and correct the DTB indices in vendor_boot.
> 
> The layout follows the AOSP generic boot and vendor_boot model:
> https://source.android.com/docs/core/architecture/partitions/generic-boot
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/4] configs: khadas-vim3: drop non-A/B Android defconfigs
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a2d0134bfc140b9b2092ab09cfef37a7da7c51ac
[2/4] configs: khadas-vim3: enlarge the fastboot buffer
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/349d13ce42f60dba1604accc3abb24d5f6afeb18
[3/4] configs: khadas-vim3: update the Android partition layout
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/09aee880eea6cf05e117988da1be8231b07c5bc0
[4/4] configs: khadas-vim3: fix the Android DTB index
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/7a403d3db56db9f1efba44ed145e875c23fb785d

-- 
Neil

