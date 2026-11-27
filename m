Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62012606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jluwm70b;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=TA8DM58w
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3A9E812EF;
	Fri, 27 Nov 2026 19:16:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cqrxYvhoyFvd; Fri, 27 Nov 2026 19:16:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2918D812EB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795806993;
	b=TQ6/LBr0iQYLQoJdRic9iouxtE5n/2JaQomvwuAElYPeJWQlolN1KvDq3VaBOqAmmy33
	 dyjTXU1hJSUfrU5QGK9AFIXEQxvHO726TSyQOwLpS5IHfnCzsc+ka93zRQjhwdozVqppt
	 DhtJKOdIM+ynIdtp61pYwJw/5N5NO2WM1yZKJAoPkzSc2AYTaB1i6arUoBlND3nYAhSdt
	 l5ZDU02L3ZFMOpaPW4I4lQsOgkAWE2QCa1f6zL8YnGEL6SixFTt3mmE5Bvymqo9d1LOd1
	 OwtgHdMhisIJUP0joYxv2j1A3r5qkzNQhxi0KvfaJz+ZIEniARvTcExks8UpG4PXJLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795806993;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=DtN4JdNvYoz5jNzEuz1Gr/4AaOKAAqfSZ4H/R6cazj8=;
	b=PpiWiTMbyXVqXDBSYVvGEXBCrZ2h42K2iK1QcDUnvhxs7bTcRXJtKiBBLTL7fkbSg0Gh
	 iZrJcmNN4yJvo/PvqnISgTn4/p1KuFOjhOxRxOv773tyNCld6TJ3+ZLhKDVO9jBZwLIJ3
	 kFf++dIpSZ3KFIbhocKcMAJq75sIjM1cYdu7cpc6c3szvs8JX+hIIvodgZXXztHl3UBfB
	 KBm/JfPY+jLC9/b/zKB41jdgEK2TRSn487qQQKDUjG2WOYm0/tfHcedE8uMtlcEhoAp4N
	 mAFSRomKuhCX1JaFVTKGhDMflaDZx1uYQl2LXcz+SHn5BdQBU6X1L05wjamq1pgfETg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795806993;
	bh=DtN4JdNvYoz5jNzEuz1Gr/4AaOKAAqfSZ4H/R6cazj8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jluwm70bj/S56KH3zhw6uathfy0bfMW585S/TlyiQcJpNcnkukXujOoAJOdwHPepr
	 o19p/Fsa8HgCQ5LvnVuyXWI8ch6mREBi0rUHsnrmWecB18rE1Scj5RtyUW+GK63/NU
	 wBr1U4EOV1NKjcyJZGA7QhO+kZVCBljT3OAudOzGET6swupGP4v1ejltv4KzvRQIhT
	 wjtqs0qy8oMaYHWt6WacVFEYEPXK7rAasEuwO9E+PaOPkT8mliM1DH8INhYPOC8Dhg
	 m2DXFPvd821e/AhZRIo+Per7rQvJaTzFg258OeQXcBT444DqWprwQ/Qy9ZwkXaHvu4
	 Qmh7yFeMv6Vsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2918D812EB;
	Fri, 27 Nov 2026 19:16:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EF4E373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24F7C40B4B
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:16:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GGhNHhPKXb81 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 19:16:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 39CB340B29
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=TA8DM58w
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 39CB340B29
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:16:22 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-84a248254f4so5014157a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795806982; x=1796411782;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DtN4JdNvYoz5jNzEuz1Gr/4AaOKAAqfSZ4H/R6cazj8=;
 b=TA8DM58wUnDPsJhSq2jGfD9spQtpGwjFNdI+o6fy9eZoUZ9J+NjTwMaBfpsxDMYCr8
 IuGnwyphBXs4jJvyZgLQlk3QUzmOAx0UYZNXofEjogf8IS03/keIjEF8VCfdwC1vaz5H
 8DlQEnTuT7Q5AIL8tTuAIPASmPg6OS7SMgW2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795806982; x=1796411782;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DtN4JdNvYoz5jNzEuz1Gr/4AaOKAAqfSZ4H/R6cazj8=;
 b=0rpQRpHT/map2LbVO5Ck/wrfoIkhGbvFrUp2NgAXDv6IBAVy5fm0kuXFVmcnNBOk6p
 vNwrGTp+9eWZXPJeZv+PT3sgnTXtGZPFxpyCJwdHCumGNtuyo6RGf8P/JiaPWTcuTtp8
 60HLjDNV02NHuOk8qbsD9BFBRHcfSOZIYip23/UZMnFr9DUbWJEtywOzVXU1w63OwVQd
 Rvx6OnoD2j1EI/DRpp4oT5nQZPVLJ02V8jlqV4+qDptQ7hgRetjkfjVlUtoJSQ1tRZuo
 GOWjshDuVcqAMxpZcKXjjs0J8rSouMOorboxtw6lTzoKdZ+A+3eE6r05vLuoXEtOzWRH
 MEeA==
X-Gm-Message-State: APuU4Z+LGlISVVpq2DRRqeVeJkjt3zhjRxpcBTQy38vqdgSzx2nmBe/C
 FO329ZqXTcOrS1dX4P0UWjkB2PiF6PjzIWQRIknNcdez9b1pg46qvHjACmC7WD+RtsYm77OcKQb
 ggwczboAHYg5Z
X-Gm-Gg: AZFdTZfz0iGrROoe9te4DleU+aVtaCDpLL8WS5j8VNe0DdFKP08K0GmpeoB9SYnnD6+
 RbU5S2XJITdawa0fjaRqAgjTkpLbqPFdgcIw3kPBCAXQZCsmCDNL42lfhV0vY0XA6x1BAu28y/6
 IQUpK1LyAgDGTD5CvF6GwJ0o+nfl2UKu4un/CVhJV8f6HWlgTBr5a8a0t8qqDTqHnubTQVbTrIi
 lQRyJWqXcQ29FNBFs6VZnvvTKBSEcV/hdORPLyK5hEwlJVR5BqCgMjaBVUyf6P/SVTNSBmzLR/t
 f7cl5CZ4SjB98k+bdrbkvT33Y1tCjnp2wUcyHFYFjj9QqXG+5/KvP2NETiwSE2Er+tLil+qSTzp
 9f0x5fIUxXxGgHNQoUKV4CxJqpUgZ276hREeT2cCHw3kOlOj4NSo+CrYyaUtR5vovAg1DeMmePG
 EctJeaDtSLBUcy+76B7ChrLF9jJywxU9zFolvlj7yPclb6ZiuCTvtv8HdrQQzktZWPli+DxxI+t
 YPqW806H4n+Z24Q6UPlEdz8IQulFUmrHNBzRLPyjrbo8ZNPoaYDvKje8BwWxFAlBGBioRJWPduJ
 2Vc72YKofA3L7XlmxpGmjxJVQdWWmUqSFOy2kaWjxAznATBCxNvEzBFRWEWsVDRU+zlfmQwj2/s
 ++h023+ZyAcG5oUtHNiD77B0bOelYKT1q60wQRMD/F1QwOFF+ztHKHnXaNK4dSjF6HE54WYx/rr
 sYlagTDhRPviO2ito=
X-Received: by 2002:a05:6830:3e03:b0:862:ba3a:f061 with SMTP id
 46e09a7af769-863157c920fmr26757695a34.7.1795806981952; 
 Fri, 27 Nov 2026 11:16:21 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm3258789a34.21.2026.11.27.11.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:16:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Thomas Perrot <thomas.perrot@bootlin.com>, 
 Petar Krstov <petar.krstov@kontron.com>
In-Reply-To: <34f9f758-4fa2-4469-8fea-a6cb5c75ade7@foss.st.com>
References: <34f9f758-4fa2-4469-8fea-a6cb5c75ade7@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot main / v2027.01 =
 u-boot-stm32-20261127
Message-Id: <179580698111.3581729.17385000703971819080.b4-ty@konsulko.com>
Date: Fri, 27 Nov 2026 13:16:21 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 27 Nov 2026 16:17:03 +0100, Patrice CHOTARD wrote:

> Please pull the STM32 related fixes for u-boot/main, v2027.01: u-boot-stm32-20261127
> 
> CI status: https://git.u-boot-project.org/u-boot/custodians/u-boot-stm/-/pipelines/2184
> 
> Thanks
> 
> The following changes since commit ee1b3477e3af6af1ae9b8f98bc84d2cc6f32a3a6:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


