Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DB1606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 01:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VCtwBiIe;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=e6I80SfG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89C04407FB;
	Tue, 20 Oct 2026 01:06:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZeC1B9lfXEA1; Tue, 20 Oct 2026 01:06:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D8732407F4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792458415;
	b=EuRkyedYpgg0l0FkX9jmLrul3b4o6wOB5DhZ0QCzT7Fb2DMAwHta/62zJeSQZ6J3p2P5
	 aFZcPdqhG8Yvx2ni74CuN4Yo+UrRqAasLM6q/3CI+bsn0HtSnUw3mAgUdUmVjuf2/sFIS
	 WDMW7ioRT2dkuI3eGhv4kikYYzm9nK2cB+uJXOZsMOGrniTaP6kqwVtYoWAOGHXooYZW/
	 7q6f37rOuhSz6rqvGYtbnmZihj6ZuBVYn+gbDc0SoW+zJm1v1y5LbJIcRNdXoX+uaTlUp
	 5si1j8dcm6VmxJyUvadzMYor2eE28sYLWlyfyzX63eRFEz/5fo0PO28tTaihkCCKNLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792458415;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=t4PLApxKiSTYDD3+BCkhRFD4ouWhmWyyGyVKDNBJhuk=;
	b=BwPsvVxGP9BQBWp7g2Ty8hKUHNd+EEuFiiQUpHc1z/al+oy7MMaNj51qn4R3el2OZ94Y
	 q9hZz0jC+Pourjym1fJ2XM4vXHBlWLMOB8ZD8PlGVKRlJ3Uhml+8ixIGYXAGfE9BoK4AD
	 mrT8wDZlt8yzOSigB3Shl24V9DhKStKehDaIsE/JUbjXKnmx80gDTJX89v7PXeSCjXTAK
	 SZP5n0k7csFxlDCraOu+VkO7Mcz0RSlzmn8p6WScxGVre5kBfFDK/sdUnHCIMeESus02E
	 FrYFjMEehx5pPSeU4gK02FhvJ+FxYaJ5lnAGtid9Sd/u1sodeSjPy0nO5SOvvTjZzcg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792458415;
	bh=t4PLApxKiSTYDD3+BCkhRFD4ouWhmWyyGyVKDNBJhuk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VCtwBiIeeyaPFr13eOIKSyb95oN3X6QavkGHMkrqGLVGWJ3EQqkEtOk5fMLH9pQuL
	 OctTL66oa2C5yFeIFkTY8fdnXKpC49mL129cVyII/veHDYpSYlwYhv6jDTAtfR8vUM
	 WWpYCrb6LgPiDQ6YUDmMIGl2dHmtZ8OIKoLylxLhK0FbsS3CT+EzYmk1xOYippjDqa
	 OzlbeWOCupCYi4DTmj47Plex/b4JVzDaUucIOuSXi4kcM0GwGVyI9PlVkoTkpjukt4
	 84kKyMwhAt5/iFjd0SQEjFTL73IMBi5Ftp3L16fe3DUSEedLU8FcB3c2dnYW7iw5UT
	 gxqwz0P+olupA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8732407F4;
	Tue, 20 Oct 2026 01:06:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D973279
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E7DA940313
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:06:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qdAhKXkG-FEq for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 01:06:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 371B640312
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792458412;
 b=Rpxg4Ix3SfrSvi70qqRi5Btqujd2d3gCbxfO1nQ4UT4ZWXTagZvPT6hjF9qKCsEYvNQc
 8/V5Oz6nBN/ACQtCHbJy0b7JqAhfsE+S5ABejJw2gcCOGs5TkADx5S2pPH0K78hqvf7kY
 nO9ti0Y8lG4xLv+4LZtCgM409ckKJaFzTdDWPc2l3NdZwXtFPIhowvYF5xs/T19L0GWKx
 WmeKx/W/DZq+qsJEWF4TrJimlCIj9CHfrlH2h/L7AhRvfLybwrpeec9NLGqrQPMYpPQg6
 I+nhQDvIaUTO08UCcFn4FnsD3siQYryLOHlOqzpNInscXu+rj9PM+FXcu9za/JxRRvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792458412;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=t4PLApxKiSTYDD3+BCkhRFD4ouWhmWyyGyVKDNBJhuk=;
 b=P4BGL4cmugC9HK71niDCetyWnFcp8zZeyBXK3JT3QQIXTxmbt4mCstwdrPGFG5n0zAop
 R2G5XFV55LMT6ASJFriGKIH7Mn+snEHukczMwMyXefcPm20CigYc6sNLxq1RZ8HVvr6ME
 fuhd7ffvE4OoJci7AHafCmflsBz9FS9vWuoNuuVf17zYW+dXX7jxLzd6k3pxRptt7dKxI
 Eown4lyzswyaKCymT63phSu5hy3i7dXzphkzZH6897z2Syp5w0778D44hq/+6TprzvpYv
 /Jb+xfAkeyFAThPPextjFJWj3TfZnxn4Kek4eF/Wb5jTZsOdwadhmG2jVga03VarL6Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=e6I80SfG; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=e6I80SfG
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 371B640312
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:06:51 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-845f3fa7f38so1177455a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 18:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792458411; x=1793063211;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t4PLApxKiSTYDD3+BCkhRFD4ouWhmWyyGyVKDNBJhuk=;
 b=e6I80SfGR3JtetkslH9rmgaKEJQZkmjM0IQuFdPdRQ2+pYCjn+HWjNRPhN422atQb8
 t5xzT2dzNZg62gfCJxbYvacab7jMsbXmI6rj36l1ajqDKYi/qG1NqbK9RofJ84q0T4W5
 7BWXI26QQ0fVUpI/HfAeVI1DsKyUUH0nPVR/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792458411; x=1793063211;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t4PLApxKiSTYDD3+BCkhRFD4ouWhmWyyGyVKDNBJhuk=;
 b=ha5mmyt7jMirGgFpxYwJxRcZhJf9Beo50pSimAf4tHKD2UVhSa1yMIDzNdgFsxGEq4
 cZm2tvIW9TiNOR6DwdYjqT3crCC5oXU3zx/VRx66ieOWoXbxbuwTUa0gX+eK3YDcvFDh
 53rcxKi/SqgRtJPavhrOZ/G3J31HDGqevGL9YxiVBWO4MnOvJkvivZSX15b2l2ZB0TsR
 0TuqmqPANQeB/gAujbICw2Cxs36qrDkOL8mYjliFpLxcHlwiypb09Nt71JRckREnR8r2
 /5Y72RmZdkQ3VvU9ZeStSqtVpAR9D3jsWbhfXS3Dmqd+g9rVCufSmyMbkqTgoBCdDZfR
 0NHA==
X-Gm-Message-State: AFq9FYJkseN0eQSRg7Wzz6E0uAn8dhTsr8la1QWWul/PB0o9VX2bFGmy
 GMD3JhJgFSKSREI8NvXnEkqZNK+wwkg1lpyXnYasCaKDRC24H1oiuEDwLO+cPaTUwWZeUYIUzas
 4ZcCrsjf4QvfH
X-Gm-Gg: AYBFou2r27Eit4XT/M23YVQquxiwtC9MRgriDQX7r6iW4nfEKbf0fk8WxaUQ+XxmTnA
 SMX/eEbo/Vp3zDZgsmwmst0fHRoM5USO09t/FKZPh0yuWYeEREctk7lRnMnkaigaW+gNhSBH8zd
 0i5sjsi/lFLjE+sFNWuMq8wMdBGKsptJ3ZGcxzJm5alDWvgvxk2wFJx5jOYmedjOf00Xg+JhAFl
 FCyDduK8QqxgsVMJBpQzGz6Lqz2S3AXkAYbxhGrL8vNpecnN3y6WeHKaLSgFvlbUj4jva/b0E3h
 RNIH2kSorpdneMdTg93AaVwEaziGp8zhF8Y+YAmeq4ncHMOb8YFNyTTOLYbOvUqiMGK1HPdRs9c
 KER6RK+gK1D4+3ocHo6ZrkZM1WFdYSxu4WWWu3uvbh+VkSBR/C/q2sjlurcjI/iJjS7UU8LvA5g
 HNc6x7mdLlF2dUrHhiD+lUXk9vAgb1awVc4GZa6encWLwhH0JA1oXp6dQ5Y5ie8FchTVn2/5I9f
 zRIaMCDLF1xF0BM4Jn5tl5izimTe/ZA91aidxLZzlirLVvFDiasKxRbgb8qu4GifS9XqK6Ty7YE
 nAIZwNVHoFjLNOcLkA==
X-Received: by 2002:a05:6830:348a:b0:822:e8ac:7d20 with SMTP id
 46e09a7af769-844fdad60c9mr8293139a34.6.1792458410834; 
 Mon, 19 Oct 2026 18:06:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-845b9e280dbsm7868871a34.19.2026.10.19.18.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 18:06:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Qasim Ijaz <Qasim.Ijaz@analog.com>
Cc: Peng Fan <peng.fan@nxp.com>
In-Reply-To: <dcc2d705-eef9-4346-a2da-ad42e53e973e@analog.com>
References: <dcc2d705-eef9-4346-a2da-ad42e53e973e@analog.com>
Subject: Re: [PATCH] cmd: clk: Don't truncate "clk dump" clock rates to u32
Message-Id: <179245840961.885845.948686802774246401.b4-ty@konsulko.com>
Date: Mon, 19 Oct 2026 19:06:49 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 03 Oct 2026 17:55:07 +0100, Qasim Ijaz wrote:

> show_clks() prints information about the clock tree such as the rates of
> various clocks. While doing this it gets the rate via clk_get_rate() and
> stores it in an unsigned 32 bit integer variable. This limits the clock
> rate to 4294967295 (or around 4.2GHz). If a clock rate exceeds this then
> "clk dump" will print a rate which has wrapped around the unsigned 32
> bit integer.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] cmd: clk: Don't truncate "clk dump" clock rates to u32
      commit: d452a0d4c19bc19fa476128c412cd24fe4bf41ba
-- 
Tom


