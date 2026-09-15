Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0568C88E77
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:35:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E8EC4061D;
	Tue, 15 Sep 2026 20:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vUN2bjz4U82m; Tue, 15 Sep 2026 20:35:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6ADEC40694
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789504526;
	b=H5hUE9FJcQwBtUn0X2s58x8oHyVHuGMaQF9XELbco9fKnxiX7qUjbHIHElN2krh2i5BR
	 SvWBxq540/MmF25HE+ifm2IIDy3LP7biIi0o9RxbAnXaM38dgVpbikyuQMmmMh1RG/rGz
	 rwBupoYIaKJbKN51Xt4EJPR0iwMvHZtTlVpGn/QGJ9TOHaLdRw0D/3hzFXRP+D0l+VT2I
	 p2b8i/kPQfSl7hW4TO6RZYN8CxGbeCkN6jQUthsiG2Trq3eNb8Hkt6VC3N8nctO4FfbiP
	 42DHlCecqr+CJMZdQ9DeVESqbhXxjyq2qKUABjAmpNShLWREi8WdMLVfHYqRtYKEW1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789504526;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VKVx6AiYyDvREpV+yaYfM4mYIh4MqQlMYxeAblDlFz4=;
	b=QIWOPWBNkOwrP25KJ+UhD+xopAMATZkBGny99OkyPYfd7NPa4V69VsBYvEwojzVsmKaX
	 UGhLJZT4ViI5Nh+ZILZgtc77LE/bWJxL59+JW4FVzouPFoUIpel0TzJatAS1YFVsF4xxI
	 kg/kszBy9Y6nk8H+J7d4056lz1tyO3aOUNH0aLgm1PzbMI9N5/lvg63Pj7qdEQxGbADIR
	 PFVXjCloDtQRJryQsS4HaJdQMVXOUbq2yMBkVf16B5JmxGjHjGmRQPfIZdo5vNdqaSbLc
	 FS1H1rMdvpOjAQ9Qll9zH3sVryfsQUwbOvHDfkdJiSWH24g0QxUxT+Xo9YHUsbz5ueQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789504526;
	bh=VKVx6AiYyDvREpV+yaYfM4mYIh4MqQlMYxeAblDlFz4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OskbPq96xdAAvEM6mJgYRUj49Ur5xXX2ByYmJhT/HwLRtduFbAaElmGvKJrBCV5qP
	 X2WTM2ZGbyfQyCk957zbFJBmaAPftP/z96XxHipb+BGrl0+AcFWveE6pmYMs4cRyBK
	 npgWuhZzgniAbih4h87kOIVp5jUBrKhqztJ4KFfkO+Mv2yoWZCS0rayYmGqeRJmA3g
	 hSiXxRINJCJvsKqTO7eQsQh0zvMFG/aCt325pttUxRw5MsUZrQMpPa6upe1s7IP0jz
	 3ecqHXEGmpfE0ZeZHBjwmody2jA6lCITetyVucPV0BxNL/3f+AP835TZVaeLF4KO/3
	 j+1Mck6Z1QwfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6ADEC40694;
	Tue, 15 Sep 2026 20:35:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 03043EB
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E951B80AAD
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oeIyG9XdcTAi for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:35:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3D43C80969
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789504522;
 b=JOsoRNoCy+pb0mBdGftjdz08mIhYGWbgvbTd/BhYBJNIxFoAwCG8vQsVUsMcix0oq7eo
 Y+pbRxqHMJ8/u8dp/DKJi2kf1PW7nSVdDpb8lw6RXL6LmTqLQ5CQhKs5jeJLSt09uivmn
 r4AJf9nF5RIbi9UFGh8mwqSnR+Hxjhf9zYQ9Yoy7MWZXY0Em/GkwIYbUvbhdme8zYxmwg
 WZ8PeZcl7OjGHhUq2/VZkZFXQCEHJp+D1mfwNZsurF4gwe+JpVAOg4fvE5WaZeFa8AO4D
 HTVbs4q7M8LHzALs2FLB4NnUg7VhtnAEhW/5VSIdoY+gfixhvIm/WtChLv9yichrp/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789504522;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=VKVx6AiYyDvREpV+yaYfM4mYIh4MqQlMYxeAblDlFz4=;
 b=VdE8q0+XwU7tjU/9PvGw0bYH4v5mDugRfH6Gc6WQ+V/IIe1kBNTYTP/C32XmLkxU/iF+
 lRjkXGFAKAT6/i0+joIhj/92nfYDHHMjG55lMxT72/rAFXYQNWo90ypIsVwAXvxoKGdhS
 5K5OUuEv7GhqALhWdu74ME3o6aevphrEK2rXxNibA5i1BQfmlo67DHYniwuP4MvZOItxz
 avIs+9Okzx1zPgZpp6ApoBtjqVXa6PVFq8B0mj/ojZ2Ny7yrxucHUUt8FO/ucfjxjB+bW
 26E8RNdqdZo2jR/c6Gxg1G7IrrfqNWhxuH5/F6fnnWOWl1AGoy0tLgk4YdnpjYG4x1A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=BJVxFTsf; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=BJVxFTsf
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D43C80969
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:18 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c112aaaf04so174664b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789504518; x=1790109318;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VKVx6AiYyDvREpV+yaYfM4mYIh4MqQlMYxeAblDlFz4=;
 b=BJVxFTsfA4VRl2F33O1PPUw4+HBA878gtY0UFJed4oVbUlrq4bOPud9jxl9d/XXcX7
 jRpT3cqTlkGePvABSGO+2jgtPt6nCFQuzySRUSMxlNAf3J5WSx9Txe0BhxsKp12CALaX
 uGcLjtUvMSJKKJphHZIsuqyRvCWcOTi0rpsic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504518; x=1790109318;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VKVx6AiYyDvREpV+yaYfM4mYIh4MqQlMYxeAblDlFz4=;
 b=a55Il8L/rDXK0g/Yg1Oy0dzbvoOkucn3VkZ2l9BDjUdwRu7vwSkAiYzhNNP0LaX8Xq
 OPASz0Jrt9j+KUwxBC6K+4MZtL3PGHXjJkyGVLi86FHgfktv6VGYjfCSfN88iynoXitp
 d0CoZ/3BAif7ho4v1kpbZ1U8YDCR1ZFoF8B8+p6mQNh8UAZbtJMwLraGtNlPcQRj/iVp
 u4gnt/INPiIpuHXKkAI0lKnBRLtCc9f9wzqtqrWgj8cQ1N5eS+U1WD68XqhZS0c/g8BI
 TV7lwRMPaFU43+If1QFfTqpNDmteERo1EeGectG/lwPncoeUJdHWhVBlVCe51KSXYbEy
 x6nQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGkeuzU/7dm24WHSMGr04y7J7bUB9frd6cp04ufFGbYiz5JxvLAkUsLQ5OXgVj7tODXqXBbWs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n/xgWSTM3eDB+ttW9f6+so70upfXzafhxiq59/NoVkoTSVRe4M
 P/UVgjzin4jKq+ZpkjBrE2AnCepzbHHo9jo1NM+5sLwUNHB0gbZI4DOa1JTfwJmqCJ4=
X-Gm-Gg: AYBFou1305nmw+KJ9r5HOpj05PPBYjaU1pypz9iSYiMkRofFyxA2CZrSFU9E6i3mqvc
 ocprO8Vruo317hLXcKgmM13BEbDcqroaPvQt2GU9v5PTCx6jUvfP9Y8o8bY1XiToebu22qJWnWP
 vAmVsPZnTKqlZ8SU3YaNI6X7aE4YzBp+PBWrgMt27q5VWtEpb0BkSZmEltOlWTTctJ257aw2hMY
 19ApWwIoP09Dj79RjqZxLbaZKSQzcU/mQSPjTm1z2Q7RdFWpuVv2sh8SJEblmX+sjt60GpjzlJu
 gSTI412ziXVy1sp0RXlzCNSZz8ziFG4BZARuIgDk9bYeXY7SmvISIdNRVk33JvSudajRddO0dGh
 4Dpj456pcSjzGy3KxfEjwVnXgCAWbDP9nj4n6sL/KE96LM3VXeP8bDT11rvrW/5oLyRLLdeW7c9
 lFYqpIi8GzxwdSPLTCXzrA7a8/9V0as7pal5K8slSyxEYRcjh2WH2VXCCHQqg6vWWrWar/85eMg
 PMkkS80AI7a293o0fqfa9ZGmO3usRFsn6WJD+72/iAs++lfoM+8wNWJxLkw2srqBrx8GpnbZeKg
 6EYAT9C9ElK0y3fxyflKu2/QiHxQ+g==
X-Received: by 2002:a05:6808:c299:b0:4c3:ee9e:200d with SMTP id
 5614622812f47-4ca4a3fb9demr119982b6e.7.1789504518045; 
 Tue, 15 Sep 2026 13:35:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ca20e54317sm486511b6e.2.2026.09.15.13.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>, 
 u-boot@lists.u-boot-project.org, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
In-Reply-To: <20260827-v2026-10-next-topic-am45-ofupstream-simple-pm-bus-v1-1-1b16c8f95051@baylibre.com>
References: <20260827-v2026-10-next-topic-am45-ofupstream-simple-pm-bus-v1-1-1b16c8f95051@baylibre.com>
Subject: Re: [PATCH] simple-pm-bus: Fix clk -ENOSYS check
Message-Id: <178950451725.931545.4917902074104470394.b4-ty@konsulko.com>
Date: Tue, 15 Sep 2026 14:35:17 -0600
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

On Thu, 27 Aug 2026 14:34:38 +0200, Markus Schneider-Pargmann (TI) wrote:

> clk_enable_bulk() returns 0 if CLK is not enabled. But clk_get_bulk()
> returns -ENOSYS if CLK is not enabled. So the -ENOSYS check needs to be
> for clk_get_bulk() and not clk_enable_bulk().
> 
> 

Applied to u-boot/next, thanks!

[1/1] simple-pm-bus: Fix clk -ENOSYS check
      commit: 044b64fff13cf10c78ddc445afafd029bd5929d7
-- 
Tom


