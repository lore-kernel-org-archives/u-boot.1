Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52BDCC6B01
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 19:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05F6340478;
	Mon, 12 Oct 2026 19:16:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LmcqI0Hi6CpX; Mon, 12 Oct 2026 19:16:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2A2374046C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791832583;
	b=GEGdJkbDeoZMeUdnAAgj6Z5DYaIu4QhKt45luVV52rRccHEuvrX1M2vbAY4Vk6TtCIBs
	 GzoTKLXY/PcaxGH1i9sfIX4oZKzIQI/Cs2AIuuANTDbZhzqB2pxSHU4PKE9TKc0UTneVH
	 Ti4nJBfpqULXlqF/m+jnK+vn7cQtYN5NPSYQKGWDJhHMrxNGzJbxNrpZwDIth5pn1ao30
	 TNo8B8PTu9Ha50fA4uVRh9gQBNIT31O33SqQj05rviHYQ78rbnEKuyX9WUXGR+Ug5hG7P
	 i132XF+YAHxf1EUA3z8nOqmlxxueRH57415B5gRitJMBlXDcXTudQg8nKiPAK1V8fdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791832583;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JUpUcPBibwJfO0knMQC+8bYX+x4JszwIkPCeGZHij3o=;
	b=BWjY3z7ivcvPlaR0dM9lsJnRy7htFEVtj6t38HrO147O3xef0pTgzYRKrtMqk8A9AfHf
	 C6t/g4yqAdb5sC33Ri6x56Xn+PML9jypU9xQJBdXgNO7Z9TFWg1Cnxi9onW88M4hbR0c4
	 cIeYSD/LgI7On+/Urgw7KwDaXtwNAmAWrMTxIkRn2G8761/SZKzP4GK6vzBcOn3YQIPdK
	 UF7lk8pGGDg29ZRs85vxXxeOarI7OmcWpTCpjixYvsbfe5XJ+QPGoneNmEZ8EY3ylXXsb
	 I9MFuvLvE9T9v+uDg5TiULXM/TqA8tRC9DLBs42dqOYwG26iHtSkbVqhSxQ3962wnWw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791832583;
	bh=JUpUcPBibwJfO0knMQC+8bYX+x4JszwIkPCeGZHij3o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FL8VyUo1pHvoyFPQrppxq0v8rR7Qv5w3CyQY7TpAsGf9z7pm0mmu4qULIZIXWRcYO
	 cplcP+Du8Dgkq2p1e01tQA5fvMyJVwEBBrXJOhYqbL7jfvdD/O4xJgIBFGTjkwfg1Y
	 xHF3ceHimhnhWk3UxLDYt6oj95JkckTTkFj2k5EU6flPHDaHuyWSKCKDl2JlXqHGIH
	 4I2r6ltrGsHt5/cTx5MVbT+iVtInoIXhWuFa66ycDBeCkA5StaRqt8t7w79BZn5eUz
	 zBirLqx06F1f5G4Ucj79bIq7MUebsBJLu/2E/yfKirIBc4QyKkxq6iVhxujUqBbVmO
	 5VL6pprcXyytQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A2374046C;
	Mon, 12 Oct 2026 19:16:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 203034DD
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06A38606FA
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:16:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xox8zuod_hms for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 19:16:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 22B0660667
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791832580;
 b=gMvWyGsdnch6dCEMVhq0hBj9PqWZxNtOXlIFdezciDXS1zqwZgUfo2uYYj8FJsYpXNTB
 t1ViEGg6iRSIuXOvAx/LXnhWH47ciL2A6wwSvTo+l/XE9zZWgT3xEt3CfF6edeNR+zvjd
 DYwLIO/gv0CNw8ODxUOMwT11ku5gFJgxr3DhlItJNTR+YLMlufSxLUt/77q70F2wstedv
 7S7/PlpFXK13+18gWaq4d0h+lrIQyzLvH0gG/uVWQqgxzRnAe0aP9Qj9FF65H0e6fcTSd
 F+YjEX+0fiedhxJWXkMjbiB79HFzDg7tNK6r72c+x/BVO7yN7aZIynI9JcBKTMmECPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791832580;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=JUpUcPBibwJfO0knMQC+8bYX+x4JszwIkPCeGZHij3o=;
 b=DXtQOoLLACYfLJ6Tgs9uUoizajsfJGnG8NXPZQuTCpJFqJ9rvFGxKnSgCbLF9HfZu5h1
 Sv4AWT06YiVX6pko7YTi2P4LrXS2vYv+Ob3ujyufoby2g4cmrlUbmhf6lhHVeJJ+buum/
 nSXRNPG/27MdcPKPCLfpz1ADcuUuX2b2djYvv7cv/15LBrV4TzKjyVxVWa4D24Of6lyFj
 kjEXYnsxejOLIrlsWTIQXqJKS89nz+IVZGaPXn3hj9wt4EEbkKhcqDjz4ylFRIvqThc26
 H1HClKr+fdjR+xhWPHOUZNuIjPqd55SwNthxAJwiFiaJDFVEfFCXfUtfZsL8KQasgtg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mfCpo6Xu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::b;
 helo=mail-oi2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=mfCpo6Xu
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 22B0660667
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 19:16:19 +0000 (UTC)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-51cddc2451aso407329b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791832579; x=1792437379;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JUpUcPBibwJfO0knMQC+8bYX+x4JszwIkPCeGZHij3o=;
 b=mfCpo6XuUjdUUVFLrZYnH0eTKgDBKJxEb8m+sD4CKMQDW2Appta87NwXUlhU7WGlKu
 GmRyGOe7rvTo4N5Ne9YyHZCEQNqLaOb1TndlOFOmNfa9Ou/4ntuKO9Hzv4GintDZEJGa
 clp6Qte/mclkDkjE0PZ/68hiKsqVqTvUz+7Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791832579; x=1792437379;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JUpUcPBibwJfO0knMQC+8bYX+x4JszwIkPCeGZHij3o=;
 b=OPwM0etYaVpSY4iSoA0NEV8pqybItYs6UqNc2B+VouJ5RGDuEyHIaUqVeX9ZTcTK0E
 CH+OyNUzY33xhs+YYp9csV1LtPP3N6JTcoZuqxr6dLLkwFnvnrAUT1Vt0vV3PEElpYfR
 3n6o9c89byc2EyOP9IOASfOXqwC2H0DCi4m7KZYW1glfPgwcWzybCnbZWqu7+Qd+5r0g
 Gj3pKiohh59pIVCa/LtBwrUGkqD88JD1YrWPtHJ7lBzbSQss5f5QQH/GjOP9vlx73Psm
 +EIfs9A1VuG1DKEm0+jbTh+3SF5OrdUV1zSGqI8D0euySaunndlAjw9+pyBdZd75MEYp
 7yOg==
X-Gm-Message-State: AFq9FYKLS8Ar1qwwl6KgtgnfoVau/0+hFl0RdghU9G3xiE2vu9lQJDIY
 QyKcdT8QPN+TmKxCo7X1Wi7TO9I9fdYAUnXQUsZrEl3r/fjZt0fk0tUKVA/EkihJPpk=
X-Gm-Gg: AYBFou1abMhwtCeoFQ7Wze/tDHz2Q/2LNNn8f09i3o4fTlyLYhQJ1TBJL+FYxHUBbLo
 Yb8G/4H111LOe6EiinKAvRCa4VpVjWgiuhSx+L9FBZFWMJ061oGFlUcfO/bNzaA5xuQuJj6y0Hi
 WmRuTZxWfrTXiXdFcYE9t02ET7aZakWHHD3qStgcdpCIMQrKtwbkBRVE+3nOVUdtoJ4XHhJYLwD
 iaUpJW3U4+jKjn4CXO0SwIp4KBCLKALbCdg6sxNMf3ucKpTyxcb0jUJpEtpATs5IJp8axK8NZ2s
 Zo4w9U0+7/RsKEakb//JJ+fUvyhH8an2VSwFq/zwZZ06QswxqbQg/2wmsMJPwEoRyiEpn2DD9AM
 xrYK0Fk5mLEs7wBSbX5cFuIuCg22bjxBT+8tkxGtJYAitoaiHG55tQzpJrTVo1lGQbNYMbyD1UH
 jXpQqDCK+nxc9tIW94V88jOdmaRlkZyDrQiCNbknsbJg15LtDPxs1U/mDAeVuxOw7+3jHbqL39e
 Qqh0qRSZHRN6gJRoGiOqT1gewb0vjH0aauFGZ+xdS4R38dfmt57VKZX8EtThcoT3Wq2zeo8rwvf
 Ah8LLGwNYuUvUgXKGkE=
X-Received: by 2002:a05:6808:4f49:b0:4f4:73a9:f831 with SMTP id
 5614622812f47-50c532f8a8emr10122406b6e.19.1791832578744; 
 Mon, 12 Oct 2026 12:16:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c167544b5sm12237824b6e.3.2026.10.12.12.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 12:16:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@nabladev.com>, Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <xhkdb7bjn7zkg.fsf@mkorpers-koolstof.csb>
References: <xhkdb7bjn7zkg.fsf@mkorpers-koolstof.csb>
Subject: Re: Please pull u-boot-dfu-20261012 into main
Message-Id: <179183257733.3787216.2834903073450713089.b4-ty@konsulko.com>
Date: Mon, 12 Oct 2026 13:16:17 -0600
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

On Mon, 12 Oct 2026 16:39:43 +0200, Mattijs Korpershoek wrote:

> Here is a PR for main with the following:
> 
> Fastboot:
> * Add SPL support
> * Make sparse-image phase aware
> 
> CI:
> * https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/pipelines/1546
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


