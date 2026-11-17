Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D78606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 06:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GusgXt6E;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u+va8JAw
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1B9B40541;
	Tue, 17 Nov 2026 06:15:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 62Fw87BtJco3; Tue, 17 Nov 2026 06:15:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5BB2A40753
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794896156;
	b=IxBjepgFnPMCha14UJeNdYY6rfPFrONt/aK8jlh0DaITcJoLJaTRJCpnuvcuF30uLEps
	 wGyGZQFHnJJcRZJcpGhqQ5KTFfr5r5K9QMA5l27fsHQAri/14ZeZ8K5Wvrx0gyuztq1Qe
	 vUehFbgYKG3xu/HzIbiy/4t166+lrewNOxffaPVKUTEO/FwHiDK06lsAos1U7/fn0tuRA
	 h362TZ2AkpvODxbfa4O6QjrWEgq59uF4XzV0iw/0fHsaxLEG4HmnNmFta/6NgzbO7X83U
	 ONglbcVKNEP25N3ErZunJmh4Fy5gZgBZCH8iG7dJFtYuqosZzo21Hl9rBrsf80GylRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794896156;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+Jj9XRdQ3OVvxrR1emwS9vOBCUUvyQEckunM1y/02Mc=;
	b=ktXD11MkKQfNEpEH0Sqa5YtdyI0EZ6VuRBIvWZjSHACqksFAqRtc+WpTUtIZ6iTae6BM
	 IkkYgbcVk1iYFb2F2OkbkIzX+QruV0CjJvtmAzFZExdrvW4wHafpNOCXxkzHOKxxQUZD1
	 ON0yavrtX3djHhwEN+r7FE9zjfv52XFTEWptdf21Na3FmPt1fBMDVT9NaXhcQ92lxzYEP
	 6gJltjPhqN+/tFzR8+evKKnWM+Dj1CzAsixoHtDgJDPiTJVkrBFpPHhf4oWPuQh0836c1
	 7KvYDjw3lr1LS2daOP/heFFT08MXc1Azf9Q08o7t76XR+Ky4nbvUvafjoaKbwYwCjiw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794896156;
	bh=+Jj9XRdQ3OVvxrR1emwS9vOBCUUvyQEckunM1y/02Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GusgXt6Ez8VppPuN5GrSBdDLJ8pLqVGGCMMb3VRokdBIuG8ERrMLRDONfOVCiq5qx
	 qEx7kkM9PSTPs2xObamiZpLUDezNfjqVJ6/HjjZDKvb53YFvtJelykzykn1kE9Zg2N
	 +isI8yFEUeByda8wWBstDDzSfrwvt7uTuUY3Z+lgN9EL73UukpTddAktoZSZmc5mzW
	 q+NrSDl/3PQ7FKIh3OrLk8vP815jx+OUrxMHRC25WWFrYUtyDptGsHa3lMd0kSd0hR
	 +WEafKcQVhRNLlRXXhtZf0thpQXfCphoLLPLsTqvrFFapws9fgtwzGyTIGLXtvBs8B
	 FoZOcunZFYJIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BB2A40753;
	Tue, 17 Nov 2026 06:15:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E06EAA0E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C97A540079
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:15:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xS-ggbaSYuyK for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 06:15:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 917D040048
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=u+va8JAw
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 917D040048
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:15:53 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8a39e5161c1so4383117b3a.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794896152; x=1795500952;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+Jj9XRdQ3OVvxrR1emwS9vOBCUUvyQEckunM1y/02Mc=;
 b=u+va8JAw7NTgpo8JvBqurBQay3R4nQX5vxpwT16tWYpu4hA7n+SWqXPEBjMiL6kqRY
 vRu/phoRt90ui/bQ2E7lKET4Qs0kWe0eNSV9FuQ4nNqPcU0blfdfkb74IZjfuX+wg30Z
 v8o9wpxHhfvYQHtFlVbPgvrGI3VKApzZJJvpZBtmsTZL7O+lsIqvwEaYX4mF8ldTfl7t
 ux0bmZMSr9F0wopntu5zgwpaBGfqtSWPOHpJXFg+dLzr1NIB8Rcbh1+GSF7MVMn5pJdf
 uu+VkxZkhPp3W9EFBQkZk1f3NHq/60Q6TglhGA29clhJoLIL7YfshVy+4AVcNTANpgCA
 Q+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794896152; x=1795500952;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+Jj9XRdQ3OVvxrR1emwS9vOBCUUvyQEckunM1y/02Mc=;
 b=J1xPjgzAHqEwN6zCZAMgyt3tv6Z1dGxQSQOkxA6Y9J1aeT/Yg44hWIzZsd1fU8zn1D
 Fu+ub3A4GlXAuJYDJqvgf055kdSXG4nr+Q0E8W9Yz/BXVtkrYBVSxCwt3H/pog98Nz0I
 qR4kDhLB1cnp4DzHuQSptrIk2sQE5yF8tx3r9UduS+mZjeACmvlBQT8qrrNAl8VctzeW
 ulqqU95axmo44n8LEK2IEX41yCfhCWjv6+c9/LoNdGE2i3cqNtEvI+/WOVc6klw0XNOS
 hK7gZ+bSP7DOVR/UDYBOw/oqfuSauVhXd/ui7CXJpDO5wB+++YBVrn7CFu+ZZKoa+gxa
 7GZQ==
X-Gm-Message-State: APuU4Z8joqHv0pp9dhpKPxLOI/LmJuBi0C2KVoheIv06CbDmsokTNu6A
 z5b7XAWAj7QY6VBNyKcPBlJA/NiedsCLtiQ3WpWtxBKIXKMSKEd6fykn
X-Gm-Gg: AYBFou1IA03dJ1SQZsqSCdTs+GtMf7BjlshGfqATk8kDLLU/0DrZYJaYYKBEQO2DT4G
 dM9dmBDX/zK0bV6pY9D+VVIxVjEno1HCnV7eaW1b0t5yKXLJ8QGmfxONAGiuSsMIe1l90DL7oPo
 BWS92TUo5zvlqaO6ZWUwSmohdYjTKnRc9J+bv2+TWs/u29miWA+zbc3N2JOS+DhOUXUkk6VLB3d
 oA4ntrVJHzhjuLFP0liSwu+7nEdGo0rf0omQmi6hSbUi5jaBWM47OTxX5nYzdMaOfXB7qqKqP4X
 vCf4xZW4lfGVlL5/OWnNjyd3BPkSfEAnr2ntQiFKqWkz8YWWWQH0FMjX/rN7zuMi4H255ROp1Wx
 utxd6oULURNwT6PqJwszWBuWJ3JixoVPgZABX7AmWU4wqIPr+dD9CSRTLGe24vSxHm4q516/oF6
 VaXwDrhnspJDE3iXwML0wd8HYViUt9YC1XRQylIfAZ6gK0X4IcWRg/g6b44DLndZ3rm6AjDhm/w
 4OoIus7mlfmw0IMZOZUSvksos7zNLM7EDFvhTTkytq7y+24AZ3r8NePl7pFTyzrMHza0Yisvm1w
 WVHI2iHqT8T+gez9fc4qTdNPU91I/XOETBA3Kkn3M9oWizN98IvqGfwcak0V+49s
X-Received: by 2002:a05:6a00:1a87:b0:8b2:cb4d:5caa with SMTP id
 d2e1a72fcca58-8beb6199b4bmr12185221b3a.22.1794896152398; 
 Mon, 16 Nov 2026 22:15:52 -0800 (PST)
Received: from google.com ([2a00:79e0:2039:4:4074:47bf:1530:a459])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8bed2635285sm4810687b3a.44.2026.11.16.22.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 22:15:51 -0800 (PST)
Date: Tue, 17 Nov 2026 14:15:44 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Bradley Morgan <bradley.morgan@linux.dev>,
 Daniel Palmer <daniel@thingy.jp>, David Lechner <dlechner@baylibre.com>,
 Eugen Hristev <ehristev@kernel.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Leo Liang <leo.liang@sifive.com>, Mario Six <mario.six@gdsys.cc>,
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tim Ouyang <tim609@andestech.com>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Zhuxu Ran <zhuxu_ran@zohomail.com>
Subject: Re: [PATCH] sysreset: Constify driver ops
Message-ID: <avvxEF5W5kRbDFAj@google.com>
References: <20261116174340.3488324-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116174340.3488324-1-marek.vasut+renesas@mailbox.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 06:43:33PM +0100, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com> # qemu virt-ctrl

> ---
> Cc: Bradley Morgan <bradley.morgan@linux.dev>
> Cc: Daniel Palmer <daniel@thingy.jp>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Eugen Hristev <ehristev@kernel.org>
> Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> Cc: Hiago De Franco <hfranco@baylibre.com>
> Cc: Julien Stephan <jstephan@baylibre.com>
> Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
> Cc: Leo Liang <leo.liang@sifive.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Tien Fong Chee <tien.fong.chee@altera.com>
> Cc: Tim Ouyang <tim609@andestech.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: Yao Zi <me@ziyao.cc>
> Cc: Zhuxu Ran <zhuxu_ran@zohomail.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  drivers/sysreset/poweroff_gpio.c           | 2 +-
>  drivers/sysreset/sysreset-ti-sci.c         | 2 +-
>  drivers/sysreset/sysreset_ast.c            | 2 +-
>  drivers/sysreset/sysreset_at91.c           | 2 +-
>  drivers/sysreset/sysreset_cv1800b.c        | 2 +-
>  drivers/sysreset/sysreset_gpio.c           | 2 +-
>  drivers/sysreset/sysreset_max77663.c       | 2 +-
>  drivers/sysreset/sysreset_max8907.c        | 2 +-
>  drivers/sysreset/sysreset_microblaze.c     | 2 +-
>  drivers/sysreset/sysreset_mpc83xx.c        | 2 +-
>  drivers/sysreset/sysreset_octeon.c         | 2 +-
>  drivers/sysreset/sysreset_palmas.c         | 2 +-
>  drivers/sysreset/sysreset_psci.c           | 2 +-
>  drivers/sysreset/sysreset_qemu_virt_ctrl.c | 2 +-
>  drivers/sysreset/sysreset_raa215300.c      | 2 +-
>  drivers/sysreset/sysreset_resetctl.c       | 2 +-
>  drivers/sysreset/sysreset_sandbox.c        | 4 ++--
>  drivers/sysreset/sysreset_sbi.c            | 2 +-
>  drivers/sysreset/sysreset_socfpga.c        | 2 +-
>  drivers/sysreset/sysreset_socfpga_soc64.c  | 2 +-
>  drivers/sysreset/sysreset_sti.c            | 2 +-
>  drivers/sysreset/sysreset_syscon.c         | 2 +-
>  drivers/sysreset/sysreset_tegra.c          | 2 +-
>  drivers/sysreset/sysreset_tps65910.c       | 2 +-
>  drivers/sysreset/sysreset_tps80031.c       | 2 +-
>  drivers/sysreset/sysreset_x86.c            | 2 +-
>  drivers/sysreset/sysreset_xtfpga.c         | 2 +-
>  27 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/sysreset/poweroff_gpio.c b/drivers/sysreset/poweroff_gpio.c
> index d9220024f47..ca695393136 100644
> --- a/drivers/sysreset/poweroff_gpio.c
> +++ b/drivers/sysreset/poweroff_gpio.c
> @@ -72,7 +72,7 @@ static int poweroff_gpio_probe(struct udevice *dev)
>  	return gpio_request_by_name(dev, "gpios", 0, &priv->gpio, flags);
>  }
>  
> -static struct sysreset_ops poweroff_gpio_ops = {
> +static const struct sysreset_ops poweroff_gpio_ops = {
>  	.request = poweroff_gpio_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset-ti-sci.c b/drivers/sysreset/sysreset-ti-sci.c
> index 451fc5de735..2674d6f07c5 100644
> --- a/drivers/sysreset/sysreset-ti-sci.c
> +++ b/drivers/sysreset/sysreset-ti-sci.c
> @@ -55,7 +55,7 @@ static int ti_sci_sysreset_request(struct udevice *dev, enum sysreset_t type)
>  	return ret;
>  }
>  
> -static struct sysreset_ops ti_sci_sysreset_ops = {
> +static const struct sysreset_ops ti_sci_sysreset_ops = {
>  	.request = ti_sci_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_ast.c b/drivers/sysreset/sysreset_ast.c
> index 4e15ebd53cc..021359a86a7 100644
> --- a/drivers/sysreset/sysreset_ast.c
> +++ b/drivers/sysreset/sysreset_ast.c
> @@ -46,7 +46,7 @@ static int ast_sysreset_request(struct udevice *dev, enum sysreset_t type)
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops ast_sysreset = {
> +static const struct sysreset_ops ast_sysreset = {
>  	.request	= ast_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_at91.c b/drivers/sysreset/sysreset_at91.c
> index 457042c7aae..6e865e1e9e6 100644
> --- a/drivers/sysreset/sysreset_at91.c
> +++ b/drivers/sysreset/sysreset_at91.c
> @@ -51,7 +51,7 @@ static int at91_sysreset_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct sysreset_ops at91_sysreset = {
> +static const struct sysreset_ops at91_sysreset = {
>  	.request = at91_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_cv1800b.c b/drivers/sysreset/sysreset_cv1800b.c
> index 74ba2c2bd8f..6bb4a285cf1 100644
> --- a/drivers/sysreset/sysreset_cv1800b.c
> +++ b/drivers/sysreset/sysreset_cv1800b.c
> @@ -63,7 +63,7 @@ static int cv1800b_sysreset_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct sysreset_ops cv1800b_sysreset = {
> +static const struct sysreset_ops cv1800b_sysreset = {
>  	.request = cv1800b_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_gpio.c b/drivers/sysreset/sysreset_gpio.c
> index 47018844a51..bb9d285f5d4 100644
> --- a/drivers/sysreset/sysreset_gpio.c
> +++ b/drivers/sysreset/sysreset_gpio.c
> @@ -33,7 +33,7 @@ static int gpio_reboot_request(struct udevice *dev, enum sysreset_t type)
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops gpio_reboot_ops = {
> +static const struct sysreset_ops gpio_reboot_ops = {
>  	.request = gpio_reboot_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_max77663.c b/drivers/sysreset/sysreset_max77663.c
> index 8febcf8de6c..a4ed763f743 100644
> --- a/drivers/sysreset/sysreset_max77663.c
> +++ b/drivers/sysreset/sysreset_max77663.c
> @@ -41,7 +41,7 @@ static int max77663_sysreset_request(struct udevice *dev,
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops max77663_sysreset = {
> +static const struct sysreset_ops max77663_sysreset = {
>  	.request = max77663_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_max8907.c b/drivers/sysreset/sysreset_max8907.c
> index 6f62af9bffe..ac268dc5e61 100644
> --- a/drivers/sysreset/sysreset_max8907.c
> +++ b/drivers/sysreset/sysreset_max8907.c
> @@ -26,7 +26,7 @@ static int max8907_sysreset_request(struct udevice *dev, enum sysreset_t type)
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops max8907_sysreset = {
> +static const struct sysreset_ops max8907_sysreset = {
>  	.request = max8907_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_microblaze.c b/drivers/sysreset/sysreset_microblaze.c
> index b81d82f046b..031b6cd72e0 100644
> --- a/drivers/sysreset/sysreset_microblaze.c
> +++ b/drivers/sysreset/sysreset_microblaze.c
> @@ -20,7 +20,7 @@ static int microblaze_sysreset_request(struct udevice *dev,
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops microblaze_sysreset = {
> +static const struct sysreset_ops microblaze_sysreset = {
>  	.request = microblaze_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_mpc83xx.c b/drivers/sysreset/sysreset_mpc83xx.c
> index dca49299f77..4aa1707d4fd 100644
> --- a/drivers/sysreset/sysreset_mpc83xx.c
> +++ b/drivers/sysreset/sysreset_mpc83xx.c
> @@ -203,7 +203,7 @@ static int mpc83xx_sysreset_get_status(struct udevice *dev, char *buf, int size)
>  	return 0;
>  }
>  
> -static struct sysreset_ops mpc83xx_sysreset = {
> +static const struct sysreset_ops mpc83xx_sysreset = {
>  	.request	= mpc83xx_sysreset_request,
>  	.get_status	= mpc83xx_sysreset_get_status,
>  };
> diff --git a/drivers/sysreset/sysreset_octeon.c b/drivers/sysreset/sysreset_octeon.c
> index c16223720e5..c08243e7c0b 100644
> --- a/drivers/sysreset/sysreset_octeon.c
> +++ b/drivers/sysreset/sysreset_octeon.c
> @@ -32,7 +32,7 @@ static int octeon_sysreset_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct sysreset_ops octeon_sysreset = {
> +static const struct sysreset_ops octeon_sysreset = {
>  	.request = octeon_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_palmas.c b/drivers/sysreset/sysreset_palmas.c
> index 9e3aa403488..e80c78ca482 100644
> --- a/drivers/sysreset/sysreset_palmas.c
> +++ b/drivers/sysreset/sysreset_palmas.c
> @@ -41,7 +41,7 @@ static int palmas_sysreset_request(struct udevice *dev,
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops palmas_sysreset = {
> +static const struct sysreset_ops palmas_sysreset = {
>  	.request = palmas_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_psci.c b/drivers/sysreset/sysreset_psci.c
> index 89b4f2dcaec..1bf6af0821b 100644
> --- a/drivers/sysreset/sysreset_psci.c
> +++ b/drivers/sysreset/sysreset_psci.c
> @@ -30,7 +30,7 @@ static int psci_sysreset_request(struct udevice *dev, enum sysreset_t type)
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops psci_sysreset_ops = {
> +static const struct sysreset_ops psci_sysreset_ops = {
>  	.request = psci_sysreset_request,
>  	.get_status = psci_sysreset_get_status,
>  };
> diff --git a/drivers/sysreset/sysreset_qemu_virt_ctrl.c b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
> index ce15e776f8f..cd693eb55e1 100644
> --- a/drivers/sysreset/sysreset_qemu_virt_ctrl.c
> +++ b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
> @@ -45,7 +45,7 @@ static int qemu_virt_ctrl_request(struct udevice *dev, enum sysreset_t type)
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops qemu_virt_ctrl_ops = {
> +static const struct sysreset_ops qemu_virt_ctrl_ops = {
>  	.request = qemu_virt_ctrl_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_raa215300.c b/drivers/sysreset/sysreset_raa215300.c
> index 32dfcb0aec8..17cb35c4e9c 100644
> --- a/drivers/sysreset/sysreset_raa215300.c
> +++ b/drivers/sysreset/sysreset_raa215300.c
> @@ -47,7 +47,7 @@ static int raa215300_sysreset_request(struct udevice *dev, enum sysreset_t type)
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops raa215300_sysreset_ops = {
> +static const struct sysreset_ops raa215300_sysreset_ops = {
>  	.request = raa215300_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_resetctl.c b/drivers/sysreset/sysreset_resetctl.c
> index fbe3999b960..f06382956ce 100644
> --- a/drivers/sysreset/sysreset_resetctl.c
> +++ b/drivers/sysreset/sysreset_resetctl.c
> @@ -21,7 +21,7 @@ static int resetctl_reboot_request(struct udevice *dev, enum sysreset_t type)
>  	return reset_assert_bulk(&priv->resets);
>  }
>  
> -static struct sysreset_ops resetctl_reboot_ops = {
> +static const struct sysreset_ops resetctl_reboot_ops = {
>  	.request = resetctl_reboot_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_sandbox.c b/drivers/sysreset/sysreset_sandbox.c
> index 93179f90bbb..a9fa187945d 100644
> --- a/drivers/sysreset/sysreset_sandbox.c
> +++ b/drivers/sysreset/sysreset_sandbox.c
> @@ -95,7 +95,7 @@ int sandbox_sysreset_get_last(struct udevice *dev)
>  	return state->jumped_fname ? SYSRESET_WARM : SYSRESET_POWER;
>  }
>  
> -static struct sysreset_ops sandbox_sysreset_ops = {
> +static const struct sysreset_ops sandbox_sysreset_ops = {
>  	.request	= sandbox_sysreset_request,
>  	.get_status	= sandbox_sysreset_get_status,
>  	.get_last	= sandbox_sysreset_get_last,
> @@ -113,7 +113,7 @@ U_BOOT_DRIVER(sysreset_sandbox) = {
>  	.ops		= &sandbox_sysreset_ops,
>  };
>  
> -static struct sysreset_ops sandbox_warm_sysreset_ops = {
> +static const struct sysreset_ops sandbox_warm_sysreset_ops = {
>  	.request	= sandbox_warm_sysreset_request,
>  	.get_status	= sandbox_warm_sysreset_get_status,
>  	.get_last	= sandbox_warm_sysreset_get_last,
> diff --git a/drivers/sysreset/sysreset_sbi.c b/drivers/sysreset/sysreset_sbi.c
> index 458191206b2..c4a71363e62 100644
> --- a/drivers/sysreset/sysreset_sbi.c
> +++ b/drivers/sysreset/sysreset_sbi.c
> @@ -38,7 +38,7 @@ static int sbi_sysreset_probe(struct udevice *dev)
>  	return -ENOENT;
>  }
>  
> -static struct sysreset_ops sbi_sysreset_ops = {
> +static const struct sysreset_ops sbi_sysreset_ops = {
>  	.request = sbi_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_socfpga.c b/drivers/sysreset/sysreset_socfpga.c
> index a07b0f4fd55..8d979ff7333 100644
> --- a/drivers/sysreset/sysreset_socfpga.c
> +++ b/drivers/sysreset/sysreset_socfpga.c
> @@ -43,7 +43,7 @@ static int socfpga_sysreset_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct sysreset_ops socfpga_sysreset = {
> +static const struct sysreset_ops socfpga_sysreset = {
>  	.request = socfpga_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_socfpga_soc64.c b/drivers/sysreset/sysreset_socfpga_soc64.c
> index e1267ac118a..5e4fcf95b6c 100644
> --- a/drivers/sysreset/sysreset_socfpga_soc64.c
> +++ b/drivers/sysreset/sysreset_socfpga_soc64.c
> @@ -76,7 +76,7 @@ static int socfpga_sysreset_request(struct udevice *dev,
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops socfpga_sysreset = {
> +static const struct sysreset_ops socfpga_sysreset = {
>  	.request = socfpga_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_sti.c b/drivers/sysreset/sysreset_sti.c
> index 110b7e23afa..862b9411392 100644
> --- a/drivers/sysreset/sysreset_sti.c
> +++ b/drivers/sysreset/sysreset_sti.c
> @@ -65,7 +65,7 @@ static int sti_sysreset_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct sysreset_ops sti_sysreset = {
> +static const struct sysreset_ops sti_sysreset = {
>  	.request	= sti_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_syscon.c b/drivers/sysreset/sysreset_syscon.c
> index d853830d5ae..2b485963a30 100644
> --- a/drivers/sysreset/sysreset_syscon.c
> +++ b/drivers/sysreset/sysreset_syscon.c
> @@ -35,7 +35,7 @@ static int syscon_reboot_request(struct udevice *dev, enum sysreset_t type)
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops syscon_reboot_ops = {
> +static const struct sysreset_ops syscon_reboot_ops = {
>  	.request = syscon_reboot_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_tegra.c b/drivers/sysreset/sysreset_tegra.c
> index 10bcd3a1873..d498aaea73a 100644
> --- a/drivers/sysreset/sysreset_tegra.c
> +++ b/drivers/sysreset/sysreset_tegra.c
> @@ -29,7 +29,7 @@ static int tegra_sysreset_request(struct udevice *dev,
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops tegra_sysreset = {
> +static const struct sysreset_ops tegra_sysreset = {
>  	.request = tegra_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_tps65910.c b/drivers/sysreset/sysreset_tps65910.c
> index 98da56661c0..957c73f04f2 100644
> --- a/drivers/sysreset/sysreset_tps65910.c
> +++ b/drivers/sysreset/sysreset_tps65910.c
> @@ -43,7 +43,7 @@ static int tps65910_sysreset_request(struct udevice *dev,
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops tps65910_sysreset = {
> +static const struct sysreset_ops tps65910_sysreset = {
>  	.request = tps65910_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_tps80031.c b/drivers/sysreset/sysreset_tps80031.c
> index 50024fe4e79..1a0dc2adb16 100644
> --- a/drivers/sysreset/sysreset_tps80031.c
> +++ b/drivers/sysreset/sysreset_tps80031.c
> @@ -29,7 +29,7 @@ static int tps80031_sysreset_request(struct udevice *dev,
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops tps80031_sysreset = {
> +static const struct sysreset_ops tps80031_sysreset = {
>  	.request = tps80031_sysreset_request,
>  };
>  
> diff --git a/drivers/sysreset/sysreset_x86.c b/drivers/sysreset/sysreset_x86.c
> index c2f28c65280..51eb16bc551 100644
> --- a/drivers/sysreset/sysreset_x86.c
> +++ b/drivers/sysreset/sysreset_x86.c
> @@ -144,7 +144,7 @@ static const struct udevice_id x86_sysreset_ids[] = {
>  	{ }
>  };
>  
> -static struct sysreset_ops x86_sysreset_ops = {
> +static const struct sysreset_ops x86_sysreset_ops = {
>  	.request = x86_sysreset_request,
>  	.get_last = x86_sysreset_get_last,
>  };
> diff --git a/drivers/sysreset/sysreset_xtfpga.c b/drivers/sysreset/sysreset_xtfpga.c
> index ab71ea11a0b..2165a1cfdcd 100644
> --- a/drivers/sysreset/sysreset_xtfpga.c
> +++ b/drivers/sysreset/sysreset_xtfpga.c
> @@ -25,7 +25,7 @@ static int xtfpga_reset_request(struct udevice *dev, enum sysreset_t type)
>  	return -EINPROGRESS;
>  }
>  
> -static struct sysreset_ops xtfpga_sysreset_ops = {
> +static const struct sysreset_ops xtfpga_sysreset_ops = {
>  	.request	= xtfpga_reset_request,
>  };
>  
> -- 
> 2.53.0
> 
