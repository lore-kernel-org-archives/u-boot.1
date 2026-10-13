Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F19CA9EDE
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 03:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E072040624;
	Tue, 13 Oct 2026 03:37:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KFl42bkD78ed; Tue, 13 Oct 2026 03:37:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3427F405E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862626;
	b=eHS/Tpe9yDo1uZjbUoZNAlshCXUBlKLW9HXG/OpfknuPXy8oVunXf69qVtPAmSQE6iIf
	 HRynyoW9Yk5nYSIZRM2qHsmzOmU7HNb5mHn3TG0xqW7X9T8wDEm7A4jNz3WrHOhqdtn1h
	 VAJ6iC8QMmXmwpfdisbWSwIZotOjWDhNAJcE+xsMTwgzrFVpKnY3sdkiWO0bGNDx7rP5D
	 Hnglb2p1TLUtkhnb9KsdexovBcQvjzgUZcVgj0rZmLuvk5ZYb8cv56zoDCUGJ4UYBO/G4
	 77Y/BgW2R8wSoz2SqrVAtKywTFuhZvP/4ooQ7omiSWqFVUipnpNX9M1t3jeBZt98RvA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791862626;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=MGRK5/NtAZoSRjlVvy9rmyNepxflCRrrNBGHVHUG47s=;
	b=SOLLBEiNxqbpx6NGVihpGPYe/RBP7QftNwD9b+y6oNs0xjXVHJbeR61kOAfqerih5JqW
	 LO+7xtGQkY/oBIa4k8FKykI9n+67hlWVgkN9uAJK1EqyaRkKGcnlyFvr7vBqfTmXVdEpG
	 /imFpM90RCmxRrEGygGFid0sxrjKTIOQ8yn4fISkyADjKjGd+FUEG4Jc+XmHwycMuqq7L
	 es3nwISdmobKZqjt9DlPxLrGAQSxr/ucsYYqSNeBvaBFRxaHUf4qEyF7l9iWiNev+7rkv
	 GVTDmefn/L0xTH0HPxMSWtQMtRaywRQDAX0Tjx/01grfTK5tZ8Q2zHiT/qZXXSm8Q0w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791862626;
	bh=MGRK5/NtAZoSRjlVvy9rmyNepxflCRrrNBGHVHUG47s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E1HRhK2hw9jviYDU4X8ysryPzAOaFesKMiw4aXtuCJCnK4wxPr0KSDPxvYj3J6Y7J
	 cJU+jSS7RPWzfxH7FVPk/Fxdx34Vyrtxaetntj3JGQ9e/XqX8t9/RRem2r43DnAjsX
	 +3uet/+hROxapBs8xfdtItdrsEeqXhQ/Lz7fNo6eG0ZGMXPV+I/mjEIsUbi2svlDm3
	 bT9NXv4dWhM1v09sVyU+yIbySYCTEfyvfAoZ7sxT5by6M3dyaNwCPn/Vevz2w3h5+o
	 EzrxJuBmFboLcyD9lKSRA/+xBUDHcJBIOay8B4UGygROiPCFd0DsxLjedmJFKBe3xv
	 LGiIbSZzb4a2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3427F405E6;
	Tue, 13 Oct 2026 03:37:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 359DC4DD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:37:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 274B7606A7
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:37:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w4_tr1nyI5e7 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 03:37:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1F85B60622
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862623;
 b=jsF3fQE+Z7PaRcCdYlTSVrfS5xCJ8rjK/SO6cgtIybJs/SKviaS5KO6/STVlJVsW+713
 bMjdliJbIj5Ljoa0wLU9k0eub2FoVz8idCtdSIevmgQnPUEPW7/ELVx33JxzxzdbIMYe4
 2qtC3PWmSUOC1c0zjR8G7zprFqS8iYhOjeC2c+C5ug4K1Gprhiaf37pxMY5AEJT4rJZ9I
 0geRPNnZT0ju/syiirSQNZT9w91Kdn5xSowhVly6EQU9JwmPNot33j55dIIWNAAeKgtdI
 NZZLTuQzBvU6HfZyQ+rl5qUKqKsVO33upDIW+y1cOnsgGebQiwczc3wk7YgTpdKdGKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791862623;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=MGRK5/NtAZoSRjlVvy9rmyNepxflCRrrNBGHVHUG47s=;
 b=CTMXaRyT1y+a65Eqv9tpbGfjU7S/4JE5Ca+7xkcEoiyMz+ytJN+/Ud3u/yVPELvEoBSC
 +cPKcezk30jETxgwYrsAUszJynDO3bUevHuGXRyi9bpQA22L1TDxPVmofMKCyu3is/2z9
 DP/NhFu+zB0WRZFhTVl4ZBnZmqcyzXdSbaQEy+OSqFIzj0tqSmsfQx2ki7QO9E5jhna6W
 pWs0VNi+2ZkdwIlXexOKTgzUL4YVKuAVfHb7ZYISbeAI1kEsQlrSPcQ+UPzQWiJk9bFog
 vNUpQ/DMbxr33JQLRBfTmZqNdBENXyzn90emdCLwCV27RZZBWQ6sdmVQotyBCQBYEew==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PuWKFt9u; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PuWKFt9u
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1F85B60622
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:37:01 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso5165196a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:37:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862620; cv=none;
 d=google.com; s=arc-20260327;
 b=bQAyXrUbZqpVu7eXHS7tDkU7zFgsqA9Kaf4P9fQ5diqg5JBxY0PRD/OOM4A1f1DbEd
 ACAI3WgVDMaiCacGHIn0wmwhoWcBX54Qope8SOab3xOwFZkuakCrjSMZqLIn5m9lCTPx
 ugLTmEZVBBgJoQxsLO5BV1ZMShe3psxkX/zWlwxdoi69WIgn8DEZ/7AUdvNS3sNA1mWK
 9QMqBuv++6P32tPHIX+VL8SthiBQfLAWgWTYshbBS5NF++p1HoVBEw2nb37Ybfx61ODp
 4Ctlgr+EdanFgdbyz8K1qoGbKholog8398Q2waVWZxJFnRKWCniKBZkuyxk2hNxk3PeQ
 fqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MGRK5/NtAZoSRjlVvy9rmyNepxflCRrrNBGHVHUG47s=;
 fh=wOkildQjP3ynoYgrqprQOGZg0/pUcyiI8bSeQ7hRHQk=;
 b=YHDu9y+X0bw3CbNM93Lfs5IQWps/l0WB0vv35nwWl5gkFzSN16JX0ABVQN85SFQPjd
 MUY3jyb/ZIT8yVs9lXnNsEndErL/PZes3IyzsUGIQTJbTTV1MHR9WpmNHQUoboXxSODd
 +qzaTfDogq+JmKX3DBGS334ClUTp7JojIZ5phtwv8/tjEsnmapkRNAvhom7kX581qMXQ
 YGn52HWC6lB7y+vcuilWkSmHLfpwxM7+cYqQXnoA/N8D0oxWg8gEOvKTKkJOR3XDxV0c
 C+Xq0XDd5WYlXe11HoO6bDSWhQez0PC5R/1bmES4ymtoAF6Rb6T1mmHWH/c+3LOMk58o
 jOlA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791862620; x=1792467420;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MGRK5/NtAZoSRjlVvy9rmyNepxflCRrrNBGHVHUG47s=;
 b=PuWKFt9ukbxKi+hRQP4N1DOPyrKQDolf2NrDBF3S8fDUmiAI2VlbYpaS6J2b9Ga6cK
 JMjv/6mFjpcSoDKJbvVA7+ZBq/UY2Z8EZ9YSRaVfK8XgijvyA45udz+90SkoOaBUirJu
 5zdRbJ9YecHz5d0tkn/94HdRdUxwrIf+pagTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791862620; x=1792467420;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MGRK5/NtAZoSRjlVvy9rmyNepxflCRrrNBGHVHUG47s=;
 b=H2ZwUs0XjbiX0DoL62Wo9IeGdx3jeFbvOoGsRsgCwN6WikK8tP20bb5wJKpZlJLDFU
 ZCr3anC0bKShGKVld6SloqwtDjs6AwlIXFM6O5ceygIRHEQWW/r3F3rdRvEo+lwUYvWn
 pYkPNGHSeO/I34lTTMfBbZNQHzObjq4i4h36cT7uMq9MRBaIYZoz0jkenaucyb48mtgj
 lgJbFd7E1xvtraRj6FkQmHNsAqvN4dKZkbj8C3Jx+u3Z13fN5zydMsMYseU7fDqTe86s
 4aVzyNTHxisZEeS9cWsfOdPGzZmeEo2/Pg37Sy8lm2A+jNsc7P9yVHG0sC2WVogNk/Bc
 dqSg==
X-Forwarded-Encrypted: i=1;
 AKwUvByjRVzKN3VGtvyAme8Lu8B+x+EV+++4QGP5H5IwHHSE/zhajdSXRMoee4I92yG7qM0UhthkXBM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIG4w3Wd5uu34Jwtjylp4HFVe0IFqwJAJ+hAy9OzFCs05rSPGXP
 7/qBZY2LtLIJlmUc0fqRW1iYwdHWxFZSyduQoSDSKj39gr92UYhI3Z+BjUuuPDwg/0fO8h8RxQp
 MTztUZuCm6Lv4j7swhq2rM9VAcp/WKEBmvmV9viy8
X-Gm-Gg: AYBFou2R30uTvZFOW+BA3xpuK74QmyD2IlzCtaylVSd51qQuA1eaq1pVbVtbdwRu9Tw
 JKMp/slds1wuAVXtAkpqImrxX8AEgnsiZCIbFM4xHDyU3rI62IaA1jmYVAHSuEXvGDj+zZPhskC
 0MuwDOTuapoBmYL9mjv+3FtELEJllW/Wqrlki7vK6VPzw4peorPH3hCWimBkVb+/7ASbD8Hd48o
 Wwifda4iVku1oRqepJJKdR9PNr4XG6SWWYLWZYN3D7yO6mvN+LfwCTy9xpa7Jz8Vnq9mcugRw0w
 Yl9np37SYK3LeBhbMLEnljC+SGPxaytN8r0tCIFdmF+6qH0JF38BTwuRMg==
X-Received: by 2002:a05:6402:4046:10b0:6b1:e072:763b with SMTP id
 4fb4d7f45d1cf-6b1e072769amr1174182a12.5.1791862619770; Mon, 12 Oct 2026
 20:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
 <20261012140048.214059-9-heinrich.schuchardt@canonical.com>
In-Reply-To: <20261012140048.214059-9-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Oct 2026 04:36:43 +0100
X-Gm-Features: AclHuK9eMFSCbpaMTgcMw2HIYw5JBOzIecy9gUFBmDud5Hwe-av0W9GrCs-G0z0
Message-ID: <CAFLszTi920A9kZ1Kw2959rz=BJNxqRP_dkdESNdXGZRBj2CErA@mail.gmail.com>
Subject: Re: [PATCH 8/9] test: env: allow optional date field in ls output
 assertion
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Huang Jianan <jnhuang95@gmail.com>, Daniel Munic <v-dmunic@microsoft.com>, 
 Tony Dinh <mibodhi@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Vincent Jardin <vjardin@free.fr>, joaomarcos.costa@bootlin.com, 
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org, 
 linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On 2026-10-12T14:00:39, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> test: env: allow optional date field in ls output assertion
>
> fs_ls_generic() now prints a date between the file size and filename
> when the filesystem sets FS_CAP_DATE (currently FAT and ext4).
>
> Adjust the assert in test_env.py().

test_env.py is a file, not a function, so the brackets are wrong. I
think you mean test_env_ext4(). Please can you also say why the old
string match fails, as in the previous patch: with a date present
there is no longer a run of three spaces between the size and the
name.

>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> test/py/tests/test_env.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
> @@ -523,7 +523,7 @@ def test_env_ext4(state_test_env):
> -        assert '8192   uboot.env' in response
> +        assert(re.search('8192 .*uboot.env', ''.join(response)))

run_command() returns a string, not a list, so ''.join(response) does
nothing and can be dropped. The rest of this file writes 'assert
re.search(...)' without the outer brackets (see line 197), so please
follow that.

As with patch 7, ' .*' no longer checks the layout. With patch 5 in
place the ext4 file should always have a valid date, so the test can
check for it:

    assert re.search(r'8192 +\d{4}-\d\d-\d\d \d\d:\d\d +uboot\.env', response)

If you want the test to also pass on builds without the date, make the
date group optional with '(...)?'. What do you think?

Regards,
Simon
