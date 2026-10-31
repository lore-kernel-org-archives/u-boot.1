Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00984606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WAHJXSeL;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QqIl/j2Y
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF25F40B43;
	Sat, 31 Oct 2026 09:34:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id prgn8oEYyoVu; Sat, 31 Oct 2026 09:34:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 301BD40B01
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439287;
	b=hjk0E5i6UgAh68aa4rFlR/+CGx996FrnPZdC1LrSIlvg8y7Z9RLb9uubdJnuslQGWCQD
	 RHptRyisrxQ0CVqLBT8fj2MK/ctend+DSMOuX3d24vKj7QoNMlGofhT0zK9zU3tEiYKkr
	 xDVBjW7g2mBLS5OBxklidC/bCuAogCKwNYnedM05B6HJ/NLjnQCXYNZ0FVV1bqC2a6gG9
	 xeedJU3EWC+TNO0Yqd+6Tmn/8xa+p6hC+28FR5LjOGJmJ8ek/TY48SzVy5eHHEdSANESZ
	 5+sIC5F2yvdlVyfeHYTirIQZkG+OJIl0Uv2fEm/GDK8JtwNTdxnssZD2Rwqk1MzoJkQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439287;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=gqVp21+onodjk6cA9n8nt6it7HKYt6CwdCvjoNOKMJk=;
	b=P0S4pmy65fLyxxdtZZ4T6p4YAhFGgd1KG26UboFSXhwQgvVtXVQ4ZpJLdo+Ym1AsT4Oc
	 Ed05+b9h863GfRdxaSjB4k+j4a0ezfLwEITEWQlFX67wqTkzkHtzjOA654bBNAPQp1QbJ
	 UDLyB3ITeAPdTf+gX298kUbBMi4qcN5ffcUk/ZzIilH5Czqg5dlSQBb2QQM7+b73zH6sE
	 Gt+mlBCbBPCSsEx3/U9bm7qT+C+DeKb7oNvii7wbUDuEiWr71mnyXSco/XMQmGqvwYUDg
	 UEwglPpEDQUf7IBTLNbWwzL0/jp0hoD7izh0xzUD+A8/7XUzxfvLw/yxzazIsmFw03A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439287;
	bh=gqVp21+onodjk6cA9n8nt6it7HKYt6CwdCvjoNOKMJk=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WAHJXSeLdugvLc8P+RTMag40lWnUQJhhP0Y4Mks9+ajhoP15SBixI5CUK3Rs7xRMH
	 5FKZ1YaXCaQ83FofJAvSETXxZY4ch6GF8JPq7VN++4c1nLpC8qfEGuNTkzc9vj+UGc
	 9oZLQK/Jw71pU2PZhm5GuI6SBeGHw84u5LDF1IFMaaenc7onjhb9fiJOg/4Gu1fHdG
	 Wl66Rd9a1DXmCX3yy+Spf9rCOUysH9PDUqkDEqQhXRvSX7NV2eu6bd9kRIAF8PPL4F
	 xE0jRhJanXrADwQfZEBbtd9rAjWz2pNa1rKWkf2eqJS5+rTlzAv+xbqq2YLDMKHO3z
	 hOnvIhUAcnAIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 301BD40B01;
	Sat, 31 Oct 2026 09:34:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D6895156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C722A810F9
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bSNmoKpBKxuy for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:34:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 44D8580CEC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439274;
 b=ghu6edU9QoICkUhGSXgcAldwI6XqQ+oCbd9yjQPvg9HF3r+POjE+pGo1qzj1IQN+gJVP
 dLSwgGx5wqGLY8YyIzRFSD3Y1CFFcpEduF1Y/yjkJJjbJGnSbbxqT+9FpEGtY/23ldYb5
 0l6uH8igox2rpdkhogllJ99rxU3iBEZbTod+C2wn1lVujTRuw2Um+EF7kk340pyT3tb6X
 EEUcf0u/4eukV+GKSfcyLtPfxOsMFJNMg3L8G4Px8PLloAKTUNeOZwRn2wjCoEP2NCCot
 YlPw/K3kDi03bVSq+zk+M+Df2ukoIEtfe69YlYXteGVHxevIO6dzOFJ3V7bgtjjkNKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439274;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=gqVp21+onodjk6cA9n8nt6it7HKYt6CwdCvjoNOKMJk=;
 b=W2UUWkuw6idmoWvaF/HR52qIeuvi923yWIVPgcY/w88AcajicmHMUrhHdzjZWvLIydCL
 i1ADuq3br7rFCcwxCB5/KlqF2OywJ/hxvO+a9jvsxL7Pd2w2wK3lR3RcQ4MbH5XF7TbZ+
 oQdwJpM99puGAUE2GY6QXfS5gHAVJ4IHxOKzZE4mY/pft3m/Ey+E/YN6cmooDlyAByFTS
 swdl9TkO7/u5YwYs5+5m9Q6PkFrZk6uOjRU76mF5IpG/8LhGrW818OjQsgAzWpJZWfjyZ
 FlXatY/XftsRC1fOTE6y0EEd+SjNC/G7k9Pf2PLyipXp0V+H9dP7pyECgl+6qHi5pbw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="QqIl/j2Y"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=QqIl/j2Y
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44D8580CEC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:34:33 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cd6a7b62ce8so573652a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439273; cv=none;
 d=google.com; s=arc-20260327;
 b=jzSBNeZx7iVLsdgl+6YoRKi/zjNabVOo0wukGu9xfwzjU9oiNC+z8sF9waALPTK69s
 ZNvyWrhgrDIJT5J5EDTYrm91US1TLv8/H5NFcdmVgNsD4gPvWQPYw4Pl48cE4oOu3B8L
 Ci3MZ0qsHLXMqRzTYf3lY9QOuNmTDAwbayQ800qXI95In0Guzz3ZGJBoT3AS0I4LWxdr
 J8IxgiViPCu+LDIFq8BgZwVB9OIweRtTDNe2bZ3vJ61RGwhzR30mugSWMt+932u75LmW
 1jhq+7CPbU1lkMb1g8M6DDmWZFPNjQzDJZGFNxnAf3sLgoswADpYdRXpOL+qwVYDS4qG
 1+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=gqVp21+onodjk6cA9n8nt6it7HKYt6CwdCvjoNOKMJk=;
 fh=pkemYDjiGTmM50s4nPzOOpScnEGo8ydvFVj0SrABrY8=;
 b=TNZR/M3RwBYbNwlQMkmqMMwulAOo2qOPZ3z1bZC2WrLrK71xMjDNq5VN3ofMYuS7dx
 a/4iJ8fH1YsXKFljO7aePtHEnm4wMgbn4eNWH5IfnAQVWOa9xArF66whLVywCRfXwl9D
 TGZOcfkPMRZU0tuZjNV3DoRxghV6Ge0fyle+RtSIThyPJBEPiga69bRCM8GsJjkYiQMc
 FYnRS6IEmXMJ8UqlbsNu1AYyBqXjCPV+vqxWLzTPlhLDdB/Le/qTqrlr7KYkHyVXVoTO
 g28k8O1IKd1UamxI9jqoZubCHlo/rS4qW7lBmyfNdaAHuSZCzikLAVhCsgyHIPwPoGEz
 HkNA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439273; x=1794044073;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gqVp21+onodjk6cA9n8nt6it7HKYt6CwdCvjoNOKMJk=;
 b=QqIl/j2YO2Z5tJJ37d6L+y2n98Kc0/Nw0DPGuw22CHdpkjbz+PfH/Mcp9Nf3LoyyRH
 QbkArs6b1iaaAs9Yu9tzgQa0+hF25Vv7cw2VLdI5K0wPPO/pI5vpwL9N9ZPcGVMyFCw3
 +Uw0pC+JnCfd1ilg2XClX5sPssLttvj8W/Zu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439273; x=1794044073;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gqVp21+onodjk6cA9n8nt6it7HKYt6CwdCvjoNOKMJk=;
 b=D+out1PDZXLQZgpVldY4RWN3lilm0RWQdrkyrJ6hcql+lEtmgPMMH765oMs1A49yDq
 FMfVKxY+N1jzVMYx6TYJzCiAEgyxv985dCWP0Q6LsrmsyjWjo2AO27bIsZ6B1fCtiOw8
 eOvyuswReFkojytZrsDUIZvs9tl9FsOfWzt6dHfdZjV1f5Dgz1ZZW1rq9lLFhfWXLVtz
 FaKGEzR59SrVd4CG4k6LnLUwUxuN39s71xBn1TfeMqU1x4Usw8Y0AbuSj+7UFGW+E9+b
 EmBmNn8LYpd/NIm6Q+5yOApsImfupQXpxa1SNdG0cOrD0Pj7JI7QfiD0mUxwryrctqA3
 n3bg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMxx1EZCahYGHWWjZWuxAL65NcVBAyzEie+wlBzh0/ZM2OjuYpoFJaC0lrs8s+ZNKQo8uXZ2c=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKjPhX67l5d442GByJMZt1s7FnA4Jzff7zIE1HtblFxqcWfVH29
 78RMv3whdYlK8IBKLueXEyJgCFyL3SIdZ3uweGUFIajyjRYe6EcHLiUGyC+pySEx1x3GHdGwfxD
 Rp54kIu4aER0JDQODTfQelMeG9M/aHNf7/xbDN4gzcBjRnuu25MVnOg==
X-Gm-Gg: AYBFou0W5vimrLDNdP8l6bTqirKTHR7T/HkfF8Sl+goDb7oGV50O7GiCiEi48P6mV42
 VX3fF6sOAUd+WHqmpUqSStx6DB5QR9Ddt9QX8FclK+LK5bChU7rvkJP8P12R6bZtfSFhwC7zsDp
 Svk4n+ooS5s/jA2piuuOLaUKIaA2xu/I6gAdwcbxbxhRGu1e8ply/KgR4ULnxFwjMqxrGy1OdD8
 0ZxVNWXb7aZNaJUT6dvLOxu5Whl+nSbmqOJ6/Td1T4bo0cm7AwYCtqLSx3JTnIIBVWk8wnwPhEk
 iV5nHsi4/x9tZkKfOu5yND86atwx8+czZXLwdjYedgTEg4qumkxrDb8apsFASR72I5KQ6r0b9Zg
 dMA58pRS15wAtO2WhLO7TC1srz14A4lVwcdx3uyYW+A4MQD+G6n2aeaQt6veMc2uvgoQaBKU=
X-Received: by 2002:a17:90b:3f84:b0:3a4:e934:e85c with SMTP id
 98e67ed59e1d1-3ae897a5c4amr3935177a91.41.1793439273353; Sat, 31 Oct 2026
 02:34:33 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:34:23 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:09:10 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-14-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-14-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:34:22 -0700
X-Gm-Features: AclHuK_kW0a_hoALn6Ib5qZxvmLBEJ6JPfMcm-I6zrBfa3o91y0hQsw9wUA5FSM
Message-ID: <CAFLszThje5+X-1CfuF+OnYkgh0tUe_06SOVmA7q9+sne7WNgGg@mail.gmail.com>
Subject: Re: [PATCH v2 13/37] clk: rockchip: rk3588: Fix ACLK_BUS_ROOT divider
 encoding
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3588: Fix ACLK_BUS_ROOT divider encoding
>
> The ACLK_BUS_ROOT divider field stores the divisor minus one. Subtract
> one when writing the field so the clock uses the intended divisor.
>
> Fixes: 7a474df74023 ("clk: rockchip: Add rk3588 clk support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
>  drivers/clk/rockchip/clk_rk3588.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
