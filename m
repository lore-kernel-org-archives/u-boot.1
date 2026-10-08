Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D30BCA600E
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 20:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E35E04091F;
	Thu,  8 Oct 2026 20:45:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id erRox4wyPznc; Thu,  8 Oct 2026 20:45:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4136E40920
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791492314;
	b=ChHcX6KIycUynSjrc8E2TDSylTzTWGOGn0owNv0WU7YZqwmOIrPwdSRZnTmFu7XP3FgN
	 3q7vl+m7takizk5Si1GNCf20wRaAoSjFuQVymrBHOmiaYcBlMd9o8i3hHXh6vP9roUxD+
	 wi4Dxd9GohgqybVczbdCKPL6V3FcMh5Ivb8YMFLnH31gVD6utGZJZ1Mw5zFTcXFamWMwq
	 5Ril1pZcJ+357s2g/x1YvAJkM38AxutZQLtVCKo7JFpT9SxwrppwX0K3iUl8Ap40uwwqS
	 e7JX0+w81gO8/zldTKf26akByCPzOXQByt6hSq6RvYdurF4lruBeGXQ5TEEdw4BJyMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791492314;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=O90lpCn94bSTDAy78MxTLyo1JfcDEMJlFrK7KtG/ZEk=;
	b=JahEaU1DW4KhpTX/aW9flUjeVhYwsBy8FarmqeKpy8TrAJcW9fQUs0WiJJF6kphKqZ5u
	 yVCr87wnhkCjhU9v/q8V6Au+ub8af1nYvKqu726vKbDsi7ARWP3X4kfr5blUXMd7mZbWv
	 Cybf787JsbrqkzhvMNh0YEy7F2WVTN//OEwIRQpwxkQBb3+TEvDuTcrloWjpelFXKcIfA
	 FmMqetJlDmRpeArS8F9ob3wrMsl6aXabPQFE9QNqp0PMwb04hnEwgCqMDTI5ocSfHaWsc
	 fUyrTjXZVNZDkA9Qq6FaLFYEYhTSi6j0f97a+A4NjbbcgQYfK2dSp+xDZnzrOLuupKw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791492314;
	bh=O90lpCn94bSTDAy78MxTLyo1JfcDEMJlFrK7KtG/ZEk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LFaDisxL2K27d3ebjYW/n9JDZHx0s6d23p54r/nsv4K2ZRz5HL3ImF+fYKKf26y+P
	 iwpw9/TVvbb28HjVI/ToOctdlMzM+atxmT8dkCZjqRXwtFl9JdZ4yv1Hh2Nx/ArcTD
	 fXbP6rjaP3Aocx9+TosLi6NeoCh0bflqFLkZQVyxbwSyWgvUV0t7ibL8vSCrIEsEDy
	 SjcOYS+QMo8jcgLgD0JUlcJlXz9+uB23n8b/ypmAdxSe7drk2uuiwWeK44e6gftCh6
	 dOTkbRPdrwushuxkUPiywZCCmvrPRZkFE+gNDyrNzJL+mNRwhDUjDySJxPhvilpAaH
	 Mcbm9f1pu9/6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4136E40920;
	Thu,  8 Oct 2026 20:45:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D8A534E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 20:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B4D6403B5
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 20:45:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d5jx991CVcu4 for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 20:45:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 841A54032E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791492311;
 b=a7CyjIv+OUs2RyMr05U8ZVmCKs6fm5duDuEKzvAkufrjPORMC3nCcNsW8kX8oiRu6STb
 IVSgAthdFwkBaXY8/LdhFFxSedKaE6xXs3McwSXDQ7Gt674ICQ/xWc/t5oODE8Ew6mb0c
 D6Pmw+y7p/7Za2NJ36Ww2R+SV/vwOG6zHic59he61Hi6dH+BebO8IqdqLvasD6a8m0C74
 b5o3Yd4sJiKy6Wt5TxoYVps7WwgQDBdoMTDp+PF+WRlbknNGTRRtWaOC4A+3NxrL5fX6v
 5RmhAq0foRYwJHBwX9pJeHtNW2sBIZSMJSVcfEagV4aAuiuhncut6IbI0Aa6BZRyMOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791492311;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=O90lpCn94bSTDAy78MxTLyo1JfcDEMJlFrK7KtG/ZEk=;
 b=p4N3ef0FTQU/YdDGwJZp8WSIvHBVJjkvzK0kDEOWE+IPcpmatVHqz9x0HJipF/eS4bkS
 EvA+16WgA1yD/dltAs8fsxNZqMgbmvzwY245YyoPPtyAZyBWja5zxAaaJg84/nc+lcLAG
 uv/wfXEdndc5pGp304JjNrXUM4OCyko/OuYzi6lETxZdO1KJTZiYl/ZRzvPKGDAseF2Ip
 kQBGGAq4wxc/m+8CoHL3B882uO0flqXpYm54EeP4SUB6LmxUFsjvTXZtHZIr2wGBW27m+
 s44jab8IUtvBqwKhBUECsVbvJ9AK7sPHUHm1mIturDklirGaPJGz3k/UIQljBGtJRrQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=DMuwYhgu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::2;
 helo=mail-oo2-x02.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=DMuwYhgu
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 841A54032E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 20:45:10 +0000 (UTC)
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-824f3901d55so2002281a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 13:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791492310; x=1792097110;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O90lpCn94bSTDAy78MxTLyo1JfcDEMJlFrK7KtG/ZEk=;
 b=DMuwYhguty8jfh9MWDRXpZNlI/Dp7V1ff3lEmECFSOmiEfFD1HKEkJ4deiVmPJYWxg
 5BL8bX7n2oXz02RGBpSDScOyHBlMOut4Nmb8aPvD9/gZkvl6FuYVlZend9V81Vj6C+0e
 DE/1bMVqka/Sf8qcbh8y2Exs3hTThlaX4wjg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791492310; x=1792097110;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O90lpCn94bSTDAy78MxTLyo1JfcDEMJlFrK7KtG/ZEk=;
 b=BlUUtkDPWhy3y77HYK/K7zYsdgCjdSZ/oWwl6l4cpJmoPp4j/HW5vLEAA8XAjoJ8p9
 CFEr0ZLJlirWzabJeJ1cHw+Tk77Bv3XOFAcsQJEietSjYAeM0GgW87ACDcUy4c0I9284
 +X5MqcaC+KkiRnnWyjfJZz2Si7e4d3J7EkGVI5AmlifUXCCr/riOHWxgyJzNxrEymPT0
 u2+RVcRkkCXTYiNHn6M8I+k5SP+xiw3DVcvG29S93P4w8+Ft2HLcZxbqWE17YzssM09M
 0XPXcwvWZD+NHlaWliBdzQg63SmfCxOp20xrus/mtBdMLgGrgbZa95X32yTymk1m5S6e
 eeyQ==
X-Gm-Message-State: AFuF++n+Xd3EJVxOD/pcY0X3ATx13FITNrCvhhve7/PKwA3c8hOisPKS
 /OaIfDe+VzI6yc4C7PeJoDTgFj8AMnSh4iSbFaMX7HYjANd02YvKyS8R4HBYGblQW8rh1gVcTns
 K7cU8rZGSSuORb/c=
X-Gm-Gg: AYBFou2qrGwpjNAJjmKjiaxgPelsdhIwlM32MkP5OGF8KR6E4AdWpEsYzUjDmYBN+Bh
 EFeggZCplboAJB2MrMrj41anUJPxJHUA2xDGRWila5demIiM5DvxaZb7Xtg/dUQ7eLhL07MgED9
 8NCbWsExCAI/VmZRZxzh0pSEVpKx3gqB0hh0EHcYM6hjeUN3QtLVqo8N+RvPs9OqAg669s8JOqy
 1h6Tnt3/Hd2dE/dIvQnRZ5ZXR8Ih0bx+Z8Xmm6ZTsei/Jca//Mo3koLnTdbfPE+Hpn3p4O1iAb+
 7EFtN8d59OoTIDAbGn4iF0p3OvEm/d8oAw21H4aQ2rT2bpUFLRwaiy8RPXJfzpPzaPpTDZwCl+n
 P98R8WDeRARxVwqgW/VPEWnfu1AyTBRELWihgQP4rHBiQXceU9MMp58cfZvJw8+mXgRhUr9C0jq
 q7UKuykfSH5KrmTx6aRuIWTwjScPzX4CCfHHH6Hrgmk8pvyHMZik9YiO0agvAvfnZQRJz6z94Q0
 VEgVrke/4IvkZXf+rJWVQslw+5RfLT3nLEjbfQGt8l5xjFXQsipJjy84vfHSqFNxjZsMi2VoUuh
 Fg/Y3Efio4w5pH4/Hw==
X-Received: by 2002:a05:6830:3492:b0:812:3a52:16f with SMTP id
 46e09a7af769-82acca6839emr7605341a34.3.1791492309614; 
 Thu, 08 Oct 2026 13:45:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-83039a3e024sm46892a34.16.2026.10.08.13.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 13:45:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, elena.popa@nxp.com, hs@nabladev.com, 
 mwalle@kernel.org
In-Reply-To: <20261008162750.1076441-1-festevam@gmail.com>
References: <20261008162750.1076441-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-main-20261008
Message-Id: <179149230846.1113733.17979369162477831605.b4-ty@konsulko.com>
Date: Thu, 08 Oct 2026 14:45:08 -0600
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

On Thu, 8 Oct 2026 13:27:50 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/main, thanks.
> 
> The following changes since commit e1dcad5512b81009eaf7e472c20a8a15db8c4a0e:
> 
>   Azure: Switch u-boot-test-hooks to git.u-boot-project.org (2026-10-07 19:35:44 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


