Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C53C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 07:24:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECF70607F5;
	Tue, 21 Jul 2026 07:24:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BFnaO454KBSU; Tue, 21 Jul 2026 07:24:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CF27607F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784618667;
	bh=3zNyAYYqlgiZ4lD8EJm8UzU6w7tdf0CIj3sG1SvwyRo=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=DC5bM0tvcF84BoSvKMLPBri89Qqx4tZx8rauo1breTPmE13eZqqtH87HN0CPNph5W
	 GJuFzu0g9Fd0opFWUk2tI9TBQ2iy21i9ZOulqQwjvv5Ap6Pj6CrKzEIHIbCbeh42Xq
	 EAsVd6l2EFZf1HsB5g/wCZkxeNFkTSEfCEdRjKekeAu9i35X3QI9b6lWOPx5qEZhtx
	 tSyDgT11uZndfvKY3k/uE8POSk8HSTISG9sWpWENEXFmi5DVurvA06NdNQNygR3mhz
	 drbBgnMN0zDVFvjotnX0LHkyjFYe9gY+jWE0tYrT5WBt4Y/stwiZ1iPYJXsl/iIQ9Z
	 LunYZKLNfiZGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CF27607F8;
	Tue, 21 Jul 2026 07:24:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E7FEA1099
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:24:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CDFDD40842
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:24:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ddrqCgPqgrNk for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 07:24:24 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3993640836
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3993640836
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3993640836
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:24:23 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BDF184659; Tue, 21 Jul 2026 09:24:22 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06CC5803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 09:24:19 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-475417f010dso6126716f8f.2
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 00:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784618658; x=1785223458;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3zNyAYYqlgiZ4lD8EJm8UzU6w7tdf0CIj3sG1SvwyRo=;
 b=TFuKW02MW0SMX4hZFDzcgl/g3sAtBC0VcMXtMWlXCybOaaQx94ed0pHQep1oyPmvrr
 lGe2xjgwUwe9HJhl566VLeA/KFkj0P8xwEm01we2ZRtmXk8liRWYRIWFe762YRkQr8p7
 nr10VpFX5qZ0VOVjPM6NKh1Sh7nKZH4+jekJ6+ZZoR+lRi64piiAhxNEFWAu2rLXnP3z
 ARzXSapGumkxpDn5uNWoqTWRoCP3y8kbDm+znF5hRWghvuGiIyxMmuQYpbRG4mILQD2R
 SlbzU0nyjgnewkSD/yZ9teg0YIM4nG5AyOM5c+Vd1FtXhOwDR0zF2ZjyLaVEkQ6VyrlH
 oOdA==
X-Gm-Message-State: AOJu0Yz2qHundj/4MCaq01XTFZO0HRHPWfHXzZ8GU8uIRDratqXPXKUa
 mzF/Xj7+a/A+VdSMt0jYBA89GGPSdIURqZ6OJHma35DuvlmgWJVXvFTmMT/WsHrXArI=
X-Gm-Gg: AfdE7ck6DJoyxEOVC4hnN4X/Y4Av+1bxABU3N8lUwB28TC7DfovK9dwGXYj4jvFXVHv
 /6oeaKTLFu5R15wgVbgd6BCBFlNh4OHkqlhnYYipoQOh7qz095YowSU31FdvyyoG3UTzpugerZm
 uIZJXUD3B47jTYQounRu/mdba9soHPpJ4hVVm5tCeUGktUoprRhwWTKHOmWKjpak9QAcAdjgh/v
 5+/qmC9i+neeAVv6SRJW7EXj0GkqThI3lTONl+kkq3WlfDn/N6Gza0ZNl+3rCeBukVOnptc0AeY
 5UY4NoU9etXGG8esVRvYkCBzN0tweXYOO6yXbrs4ZNiEW8G6on3tMR5vqZnJLQKRVGXBV58/vy7
 j7A+eHH/fUtF4HBibvZn2ePlhR1ML9lyEXxPN1pz2PxUKUHRYz/HFPiZtMxNCJrG3PuEWtqToJT
 sCNnyiLSPGRrzEs7t+a3dG044=
X-Received: by 2002:a05:600c:4503:b0:493:c84c:2b57 with SMTP id
 5b1f17b1804b1-4954a513f99mr185846485e9.29.1784618658157; 
 Tue, 21 Jul 2026 00:24:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c6besm43741545e9.8.2026.07.21.00.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 00:24:17 -0700 (PDT)
To: bhupesh.linux@gmail.com, n-francis@ti.com, trini@konsulko.com, 
 marek.vasut+renesas@mailbox.org, macpaul.lin@mediatek.com, 
 jstephan@baylibre.com, padmarao.begari@amd.com, faiz_abbas@ti.com, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, sumit.garg@kernel.org
In-Reply-To: <20260717093013.3253643-1-jorge.ramirez@oss.qualcomm.com>
References: <20260717093013.3253643-1-jorge.ramirez@oss.qualcomm.com>
Subject: Re: [PATCH] ufs: invalidate the whole descriptor data segment
 after a query read
Message-Id: <178461865755.3469279.8335215114520661783.b4-ty@b4>
Date: Tue, 21 Jul 2026 09:24:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784618658; x=1785223458; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3zNyAYYqlgiZ4lD8EJm8UzU6w7tdf0CIj3sG1SvwyRo=;
 b=hPDLpYWxs9LV3MQ6e0pGG+glJ9Wf6bufs7pt8t2jxiUr04XmCbPtrGzkA+Y15PffKi
 wRelQOS7oBRekLk7wHFQpJRam/3t8BW6BGDNBvGyVbvbSTT49QOd73jZqMMUYAP1W6Ho
 rZkwl3ht8ZXyA7wrUfhYnKWrNiGu0hRYQs0M9TZSP5bpvvRiwc0FOuM5EgJvir0FPmyB
 jlEKb09qOTc50kghIuQa/p41NidCGAgoRYKRNGCp2dcITHbrhXPmQsx8ncR/UCN/PzKz
 zNgkNwi0VR8W0c59YrlZqX4yQ50nBVvklydkcaVGO3h1F77HZnZxi6vHJaJjdwT50D1p
 wK2w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=hPDLpYWx
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=neil.armstrong@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="hPDLpYWx"; 
 dkim-atps=neutral
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
From: Neil Armstrong via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi,

On Fri, 17 Jul 2026 11:30:07 +0200, Jorge Ramirez-Ortiz wrote:
> ufshcd_get_req_rsp() invalidates only sizeof(struct utp_upiu_rsp) of the
> DMA'd response, but a READ DESCRIPTOR response's data segment follows the
> UPIU header at GENERAL_UPIU_REQUEST_SIZE and can extend past that window.
> The tail of a longer descriptor was therefore read from stale cache (the
> pre-transfer memset had zeroed it), so its last bytes came back as 0.
> 
> This corrupted the last UTF-16 code unit of longer string descriptors:
> e.g. a 34-byte product-name descriptor "THGJFGT0T25BAZZA" was read as
> "THGJFGT0T25BAZZ\0", dropping the final 'A'. Shorter descriptors that fit
> within the invalidated cache line (serial numbers, etc.) were unaffected.
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-ufs (u-boot-ufs-fixes)

[1/1] ufs: invalidate the whole descriptor data segment after a query read
      https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-ufs/-/commit/38bfdf0a770219e2f753023998bc9d0b45254785

-- 
Neil

