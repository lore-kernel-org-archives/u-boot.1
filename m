Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7212606A32C
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aBBrc2vp;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=G6A4cNhT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12806606E6;
	Tue,  3 Nov 2026 15:49:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9dDP21SM7U1U; Tue,  3 Nov 2026 15:49:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E04EB6083F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720956;
	b=EhNoaVTqCkBRdPU5ky0P2eUWRrCszFiBdhI83qxHmOuuo45usIAMuNrkYyKy9LKJte9G
	 zV6jNnFcO+TI/DAli2VQfmNdZfpDs2syT65ZrxF9soseSTgabljQGabi3JdgWcUpce67i
	 eQ5B/PLaQswh+4+7fRqpr43cB1OYsHc1P5Z2zSY3ddinn3aCX88uZ1XuM1g0tLHcoEi8+
	 jJ0KwgxCEhsNzl7aY1lg3HEY/3FkUgUYjj0UN+oYamAGUJQW8kTaizam77CfRsuCEYLHo
	 ZrZ0/ViINV2YL4WSD2Ez0h1gBfBx5Nc2IauU40kzOx5IiSOrG84DzUJ4/ffuKpuntvQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793720956;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SR7XRcZVbe4HNisfO6cohzbODe0M6Lqp4raHQvQRtyY=;
	b=k/w8gHTGmyiAXHHGbci9KYfJmE6oC7kwnpco+cFveGQMe2RKP27tkUIxTsV8HOC21Ygh
	 CB93roFcsOqIOfEX6K0RAqG0vpaqRzIGCcfO6BSFDEJEaVwhNF6HYlEoVxzkqFRSV0wPI
	 NS2UqQVoGB2mDDPEHBWLrRXj3Uzho7TSQaFr6ymRkgII4fdo13Er1zbg22Gz9oe95CpU4
	 IOPUFyscJR6yxxSe8yKgcAYnHs93m1kZFKAZp3GEZcJFAf0WnGPTFkTEWJMYfUKAPxUwL
	 3z6HSpNzvfQSgSVCUo/bOucP37rtC09VxPm+Q49ArRGC+7zxbVVJA6zbeKVlOErZA0Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793720956;
	bh=SR7XRcZVbe4HNisfO6cohzbODe0M6Lqp4raHQvQRtyY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aBBrc2vpCUwFz94oLIiOC8oCIR+pJErqERkx2MQ3/+SSnO1AK9ng2j48rqOycMK53
	 u5RKGCMabtMfoFKk+HXE9sAdINdGIQ/5VtKQCYgXD8vEbMXUzp1oUXdrNoEXwVAIIz
	 ikMQx5JbgRljg5xq4B5RkWAADFOL7G+Y5jMRPswNeGlR8VEgyjUSNU8eALZMnCb9Cx
	 YDjqTtkTkqG50GzRzzp/0QdnMhO91h4el2HxVjMRT7vpGPXcc8ywgvXAmgdNfLrRAb
	 RUuARLvDZtQf3pD4IQFS5H3sFeWDXf2Voq623Kkl8TExEOScNwUTKgcs4wEECV0NUl
	 tm7nVF1nVffnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E04EB6083F;
	Tue,  3 Nov 2026 15:49:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D727235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:49:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2EF65406B0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:49:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1vccpms8-yqA for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:49:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4246B40695
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720953;
 b=tanHDPIliit69q+0Kc6oEcJcDs5LuzxZyuJrXRoodJPjrPeoVwkHmLBJHEIU+sU88KON
 3YJ4dHRX4VWz5KlHAK8FUG2H6TLENvIE30GEvEEixoCjX1uuoGxZFcAQClniLvqWGIrvI
 yANxOyyUbdBjK/1RletazJP9/uvv9EKYFnJwbCY4KOhi88dSILTlp8NCNok3Sz+DDDa7y
 eOftGfwejAHjaiDASKJok+4yRBHaC4QZ4phs4ImrdtyDIFpRw3+ME37VMLvvaF35neM9H
 K4/qEj0yfDoHq9Lajc3KP4Jl4yHp+FdY1yrM/nZQPpk0eCrh30eRg9hLRzP4AmhZZjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793720953;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=SR7XRcZVbe4HNisfO6cohzbODe0M6Lqp4raHQvQRtyY=;
 b=J+0rVA0mtqec+KR4V8P6JSH5RjTRzgFpWYh+0qGVCHAKmTtKjA//ojvZ1oPk2O3Eew5p
 DvRhzis+ccrdRQdENeOvIdp4u7Fh2iHVtwXruvXljc2QPJmKOI36PXTJrpUrOt/t+D/R9
 +h8V2Zb3gUXLvr3qgyRJD2SIU7qn4yDG2iWjTdusrCugi5EQ0Ea2vL52lfnKH6gghd/CO
 aRvUQFbvChYgirA7hxdvsx+8j8TPrgZ/aXjn3TvzoWOQDIGqYn6bXHszc6XKXPd013vWU
 LG2BpQ/nGlR8bw56eZnY5yJ5S1tOYDAq587sjVgs5kGq03UyyuvP9Qa2jY/SdwwjFmA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=G6A4cNhT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=G6A4cNhT
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4246B40695
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:49:12 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b488586facso5474787a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:49:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793720951; cv=none;
 d=google.com; s=arc-20260327;
 b=o7/JPh9TLXHtkemoCh2fpSVu9OscQ8IxTjx6onm6sarKGDspCUJrYyO4wofqLMVcjC
 GsimG7iCiG51n+iCymc0UlPeF3U0qZrAQFt/eZJU1Y70M2PdlP4sPVrsl/bMyI9QLn7d
 FWOd8RT9/ODXwbY+/kYTQALvcby5x4T0/RfJY4GZifAONxk4f5PNvVBvTLfnHXqF2eEo
 BQYa94fc4GCYUwnKx92npEm0c+36Is9G76IiI+X9voFgMBykg/MAtL2srWdjEG0v8sLe
 cXBtEIixNpjIYCzgVmV+rs2iMcHTotpXaFRcMLAhdZEL4Q7tNbQXVESU9irqAmRmk9vQ
 vUug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=SR7XRcZVbe4HNisfO6cohzbODe0M6Lqp4raHQvQRtyY=;
 fh=vAmY7hRBdMrkxhak4XNxRo2S+aXYqAOi9P6V2g3HEEg=;
 b=ikJJJyzCUAvzy9VTIoC/MLVshbYPPcbGTV68miJ4RpBCO7xnh5I4U4u4qwv+plykwB
 AZPsWANVuALo3E100xZMHTHX3UCnFXszojo7k1ONDNURMbMNIs+zf/McZ2uynluZCHMe
 Zi4RHROmi3yfUewHOQIxCep7G5ksqpcXG9NYx8w3cfhZtM7pO23HxG+FMSoX7eehVEr5
 400MhwJxIbI4cIuiKUT4YgKJJFlNYPBlDcQtWh87ZjbDJGEkonf8VGImUrfsHeXJvcm8
 n4pgd17NH+w0mI2sMAD8uW+GyozOWIuEuqoVZGiBEqgPyPi4DSWJ3kpA26GxmC5EHhy0
 AGcw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793720951; x=1794325751;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SR7XRcZVbe4HNisfO6cohzbODe0M6Lqp4raHQvQRtyY=;
 b=G6A4cNhThf9/JNz4y6WsDaistfUDNjkpP7fQvUw4HJK5eGZr6nzmjE1VZuRHe+yaAA
 2mxTwidl9VPekoUB3NqGXPzqWMVH9boAS2X+lG4I9Ut8kBgWQwYe6UTKzVummP8jl01s
 Mz4ejp8dE/3ZnrBgwGqu38aGEwKN0fL1Z/6KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720951; x=1794325751;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SR7XRcZVbe4HNisfO6cohzbODe0M6Lqp4raHQvQRtyY=;
 b=Y1T40zgbSWV0s4oGvmqDgmBSGhKFMz+H652YoTwSBWK9d6B3cD4hedfNtDXVHX3MfP
 udzOcbH0cCsMLF8HBHaFoICxnH1Zk3hAE75Hz6hypDC0BHht4bXayv7s4o4tUspbEIFD
 6ato8J7UBJb46eIGz2jzGC1UM6gF6MOR4MpiD6Pve6dom9bbpz3EBFztX1E1pAM2Mbo1
 xXBHKdwx2x5z85bvrQxQqG6ukyblHtfvigQWIYsukfeYXQtf4RaaVNGPsYhVxMuBoibm
 ZLvizvju3ppu+si24arGuNKQUsjbX/HDzKgy9cfHtcdaPkc0PYIzJtJN12+k7HV/aGJN
 dJPg==
X-Gm-Message-State: APuU4Z9mQvunEmQCFP4xElliwZeBuUOcmwXT+vIziPHIKMvRwpFHCcQx
 3CnnH4aQ8OA+CDegu6WBTBzZeim3K3HiCQYYyMqjomCB0aig3t9Lwsogd1rLIEEpwTcCrmcRJ8q
 q2VD7k+ueke8amR1gyJkn/NjkRcymfMKdcnrwdlD1
X-Gm-Gg: AYBFou1zHqIbSKbzfqhl987Z7FnP8F90S8twXAjJ8SHAVXGKBzZ6nQxv/Jmqk+i1XHS
 VZNjLoaid1e8CdWNDCQ86eXiLQxGzQI2fJOs5wpY9N76MjXQF8tNLY0n087rZF9PgN/Mltds3H/
 4SOg7KyNXQLC0LZIscaNLhwIVcCW/2QypDAVWP7CpoNMXtYud5r/CucQUTtGOIRv+nRoWCBJjyn
 iC+k6H7j+8mOztDw4y/HI6V6WJn5Hl0m+jBP8CflTVEPaxL0i0fbIa2kWKzlbP2qAwf5DoUeC3J
 j0oO8UZweCEDFOMjAo3JuHhvJUh2SBxcN8Es1ehBJtXLe+0BT3Beu2seDtNmLVOqg4VG2j52N11
 NIp52ISeO/+OUdU+ynYvqG6JeO2A6b/7nBnQhNL8YUJY/T4QmRxjIAPheDZR/K7efVg+i4hc=
X-Received: by 2002:a05:6402:84c:b0:6b4:1c18:7c92 with SMTP id
 4fb4d7f45d1cf-6b515507dc5mr4888532a12.39.1793720950726; Tue, 03 Nov 2026
 07:49:10 -0800 (PST)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 07:49:06 -0800
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 09:38:00 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261103-riscv-full-fit-support-v3-2-e1dcdc9638e5@maquefel.me>
References: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
 <20261103-riscv-full-fit-support-v3-2-e1dcdc9638e5@maquefel.me>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Nov 2026 07:49:06 -0800
X-Gm-Features: AclHuK99K13gJfWtvbOCKlKEucjrU-KGWr3BA0qrnQm8OkeEt5_f9QomEGh1XeY
Message-ID: <CAFLszTgDru-Lr=9mm0E3SkiCR89owoS5mgLOU7QdVPDfBotpPw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] common: spl: ram: Add LOAD_FIT_FULL support
To: nikita.shubin@maquefel.me
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>
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

On 2026-11-03T09:53:01+11:00, Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> common: spl: ram: Add LOAD_FIT_FULL support
>
> The simple FIT loader lacks support for full image verification
> (CONFIG_SPL_FIT_FULL_CHECK). The full parser (spl_load_fit_image)
> provides this feature.
>
> Enable it when CONFIG_SPL_LOAD_FIT_FULL is selected. If the full load
> fails, fall back to the simple loader to preserve compatibility.
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>
>  common/spl/spl_ram.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
