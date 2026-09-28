Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C636CA5FA3
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:13:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B5BE404E7;
	Mon, 28 Sep 2026 22:13:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id il0BlKB0xcvJ; Mon, 28 Sep 2026 22:13:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2F928403BD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790633633;
	b=DEysKNe99xIG6jICvIHVEu8P3U7ipN8ZhqO47RKKUWsdY+Zr3NUf7JT3guvsmpcPygGK
	 qTA6oOTsHlBFffwxIriTW3p0+FlTthCJAUZPwM3cX3Z3KB0Y83wUUR0mhgVpwPcD+bI8o
	 qHWmQxwtMj64W0OBPD3BxGQaft7rr66RgjjKt/Ifk+y2VcYDhJOKUumxzBH6qZL+6wjTr
	 u+mtin8z7gNAvnhjKmSjq4zZjZWp+WcY+gaboiOJcY9TfXNx071wEyA8NfPShJi4qiOBA
	 09BZPTXi5phP4G1ZwseykNWiDbFLffTCYLJQ+dcbRMCcOv2XbToVsolmdWXNh+k17+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790633633;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YKWXfv6NLf18naaTCddig0Co6+ih3490yji0bPw/S+c=;
	b=gXIF2geCbzbDRqVQGORYmpTMVbgOUOK2cLBKVVPP3xsrFdd6Ghj4zIlBjN0DyIaOrs21
	 +SJBHzJadPOOgkv7Cto59utCm1ElnYpRaAsxbxUQc37/NENWsIvulCdwrbUZXcUSif0yi
	 Sjq9MNJaWSxXPPGwYS8FKgpVq2G0PiThoFYpMvmNvhQMs4pTNDeprl2jcjoPKPjwF11SP
	 qVagOKKb/JqXGlo1u6s4PfL0Ai0h1pCaibg8//3noN2oCCwEsC8KWx5DkdPhsoOjOcYoK
	 E8iemPCtd1RbYfiyUcYftA2lI1IwV/U36V96oBQIhe/nScCyozfsICc/nVoEMrmpxgQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790633633;
	bh=YKWXfv6NLf18naaTCddig0Co6+ih3490yji0bPw/S+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oMp80TFdC2inF+om2uoOpLJ9lJ3bsgm23AMstSoUNmHNSZwJXgaLzkPFe8wtna0ke
	 T87ku4lvKOWfxTEc+UX+uLu60rr16idU7Ofnevee2qqL6iCJcbe0wpn3jpAeG265Yk
	 hNZ3i74mxw2cTqHOZXBFHeEa3GMDRUo62/kspqWd73zHsr1VSrwETxUhuieU9FoYnF
	 JmuIQSzrEeY92SZ/fun+LkIfh8R6mVoNcqITGJmuw9CsKqjfAlaN988/KgYSBa3cms
	 VA9lMvU5zchoIP/T0CXH3TYH8sd4aCNMVad12Xp5lejZgJ7b5K4/kPV+eR/FLzUIQy
	 EkGCUH6qpkomg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F928403BD;
	Mon, 28 Sep 2026 22:13:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 55058335
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:13:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A22B80ACC
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:13:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7mL2LZc180GT for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:13:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8ED7E80AC5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.27.42.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790633631;
 b=CV5ArqvdhZd0NizXD72oWba8+NDJCiOWZYChVAT2MHDctAIXhBZreCB0uyGEIw4qilIt
 NdDqlSSw1p/rNlX2tntPlJKqKLEA9QXa0NtK40ggqqNl7bpQ/TgCOcExWHnrGfZ0OOw69
 FZo63Nx3A4bGLNoSlQWUP+oHf67Hm0lHCYUcnKfRFEzi6srtku5VKPrmU30qgZEnc+02m
 HQsRQyKwpdkPOeK1UN1UDLH+AIBlFh7fD86bZ1BhPHOZyNZluIW4gJB6Jx1LSD4STueDA
 V9KDkrja31VsdiBXcBlOUj3SCxoYlJI+v0XZy1TsBMB17AxAAxVPC605ukeXWtypsiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790633631;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=YKWXfv6NLf18naaTCddig0Co6+ih3490yji0bPw/S+c=;
 b=Aw2aYjTq8TvSjDAOlxZOF8uwtketMEP9Xcei40CXQP3K13apQ9X60lMoEaa1+GfxK/zl
 I4XlMg12dSJqfAxN86cjK4Kft6P+OtI21hdGUUpvl36sP1IfhbEEqqOiRCcvjUvfz40YA
 8GvQ4SBnxNwDD1ZaQwaSx059yyiSuc84+mKF3iP6j+XvfI0avj8u70Jm6nFKeqPKgPLz0
 Alag8BYQ4Z/QEMh6fg2jxsjmh0kwSkW85guMSYA+Vo+TA2vm5t64mS+H6llP3WnfBgNrt
 msl+foGkpMK3WgvmXErTZP07rNPruX8K4iEAq9l0YJLPPcX3GxuHyTdBhMR1n4FhaJA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=oGUzNImz; 
 arc=none smtp.remote-ip=212.27.42.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.4;
 helo=smtp4-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=oGUzNImz
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8ED7E80AC5
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:13:49 +0000 (UTC)
Received: from L30177.local (unknown
 [IPv6:2a01:e0a:ac2:22b0:78a2:84b2:2635:609b])
 (Authenticated sender: vjardin@free.fr)
 by smtp4-g21.free.fr (Postfix) with ESMTPSA id 3B59319F593;
 Tue, 29 Sep 2026 00:13:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790633628;
 bh=OrTuAOWNI5oOkKstIu0Mvfn0w0b9wOZX2AAZm+2qee0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oGUzNImzmfo1AsuT2/J0wD2FJNxH65jfAFFOL+AK33JpBpuu27tDe3S6hMlVwZius
 faeyZ+NduhyJg9vUwP5Y/0Pycb+/CzLYEFOJDy0aEw2OLvGRQcBz9KLage0OmDR5nZ
 naYA6WoYDxyHkSh+4ipT+tOuI5HbIwqGFbvY5/4fqdhpsNN1/IdSeZ7/3KpMzU/jMY
 9nwwvcTKjOsF01s9XyomfwId9VFJAWqUXvsCuI2YWQb2rmQupGBCPmkOi2S6o8IrtU
 wtH9uWljMuCnHrm80ZwYe6Z3T8O4ozeOQS+789K+JWRQ6STxMVhBm+C7Wt8ln+bUCo
 jntaYqUPNB+kw==
Date: Tue, 29 Sep 2026 00:13:37 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v4 09/10] doc: lx2160a: document the sd1 hwconfig option
Message-ID: <arrmkcl3utxe2X8E@L30177.local>
References: <20260928101330.881662-1-vjardin@free.fr>
 <20260928101330.881662-10-vjardin@free.fr>
 <20260928151032.uwtmyj75xics6viz@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928151032.uwtmyj75xics6viz@skbuf>
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

Hi Vladimir,

> > +		mode        dpmac.2 port   dpmac.1 port
> > +		2x100g      100GE          100GE
> > +		100g4x25g   100GE          4x 25G: dpmac.3 to dpmac.6
> > +		2x40g       40GE           40GE
> > +		40g4x10g    40GE           4x XFI: dpmac.3 to dpmac.6
> > +		100g4x10g   100GE          4x XFI: dpmac.3 to dpmac.6
> 
> How much do you plan to extend this, really?

That's it. They are the 5 scenarios I am interested in for my use cases.
I did briefly try some others split of the first 4 lanes instead of 100G
and 40G, it seems workable.

I'll leave those to who ever needs it.

> Do you ever plan to support a mode with multiple 'from' modes?
> 
> Like for example, 100g4x25g can come either from 2x100g, or from 100g4x10g.
> The sd1_enter() recursion and graph traversal becomes quite a bit more
> complicated.

I do not think it is needed starting from a uboot/boot settings.
At the current states, SD1 is always from RCW 13 (or 20).
It means that sd1 cannot be in 100G+4x10G when 100G+4x25G is requested.

> But in principle, there's nothing saying you can transition to one
> SerDes protocol just from a single source. In that sense, I think your
> choices are rather arbitrary and may not suit everyone, so talking about
> multiple sources now seems rather adequate.

I guess you are right that more transitions should be possible, but I'd
like to leave those for a later design. I guess, based on the current
user uboot shell and env/hwconfig, we can still reshuffle it later for
more scenarios.

best regards,
  Vnincent
