Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10248C624D4
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 18:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 887E540D1A;
	Wed,  2 Sep 2026 18:45:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OqDWXCE2dzcR; Wed,  2 Sep 2026 18:45:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AA74C40CF7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788374729;
	b=OOFbf6ODae6+09VNwfKXXQL9w1pxYi1cs2uUHiY1W34d1KHoI4U2gqWuerLbKqFn2K6g
	 xIINN+x1dAoSoEoS1fv9vGpuzXTH9sr37WJmE+50Ps+zB1skCaclv9YSv2a4aZovfWHUN
	 gto6BPD4C3zdiuiU7IUvBuEX13Nlr0RmGi+MH65hTt2kirVz67waCChX3YmsMI6gKEfgb
	 E0r54+24rWhBiJzXjgvHIKjU+wbb5fWPVT5bBPtl++2uq9Wlnc5YPQJePt7c1d2Ug481T
	 ksFWT/AKXAO5vWdD352nypeeeZv4uHGPSPm/DmCdGN2GPcObEJh5btNQ5ovE1iiq7Xg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788374729;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=EgDyLYuxg2SG3uS8LhCnTeh5KOlhLxeMl3puS6JG/Dg=;
	b=PlmMoKgqjcao6h1avFo8L5EAK6Tvhj4DhSUAHqrnt2sHzxwEl5E0arIIhFlm4iZzdfRt
	 8IXH/5X0xz7DxzDWXhgJvEmJBzxU4Rebpf02w+MqWPIwifafGH23Wr6qmAextkdOmsO1E
	 8X27k6cW1iz9a7z0vCEFwoZa/y372Ear84t8nZKAUfLXujRdn1PGRRqsSa+6z/ryW142D
	 ou1NFET0c/PlOzuYMnnGJHGF0Ek7/8dVNHIqqrwUK+3D7DEOX8yz0aaThWDhgn9e3RrB/
	 CrM5r2tEtJjFd4JCyL8kmfQz9bokedSZcdlL4ULE2hqARKiH/A51BhAG7bkfPllcSRA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=TFNaZKjp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788374729;
	bh=EgDyLYuxg2SG3uS8LhCnTeh5KOlhLxeMl3puS6JG/Dg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PkwEfPE40eBs1OS9esUo+gXppFIR8na71YR/R7YcAzAbvkfUpdoKLE+CFv7HRXCVe
	 ueMOQ1WquG4XCPZWGhBPff/bzemMsP3ZDZMJkbUo2B0P0eVHrQPhmXi460wYIMdWQY
	 RjZuup6D6z0ILuFHDD8qjVMHJe0xgrL2LRzkC2JaLsBi519/J+EI3eMBq9GUAlZ86s
	 W4mHlxIbcvAh8ykI/AjMG5mXaWRQL4WBIiGS4Fao7wR4I1ds01W0F4LpOem2+pFSKC
	 eqI5zVnirYvfweKlKBYwYWk99b/hOs8wZxZiIbZ8KDN4rrknvQF4fv95k1kUxNGHaH
	 l5rb8GHNaggdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA74C40CF7;
	Wed,  2 Sep 2026 18:45:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0972E334
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 18:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EF99240CF9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 18:45:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A9-OZQLKX4UO for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 18:45:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2630740CF4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788374727;
 b=LJuEzVGFV45e2sskqX0eGRAlwNqbm1r8bWlXuZFYSxjLit+TjeIHjnzHgVQeL+2ezvZe
 bveQZ0TdUSJK34cDGSGEJMCKlHMD7AF/NDQ/zgDzLZTba/IYp4J4xktjr215TDMpQGov+
 h/jlVqMSTzTTcLMb0ZONHFS+of0+/lSlBUJWEAOsw/PP6RbueREXdBk0C8g7WIV+gfKtM
 NqfjXyC5SMIprDxAEzjjQh4d8sgEhDqhbPxua0QgsIfST+V69XEubB9PYYgceaNmjX71e
 aq8ez8n8j7ebQX2SVBoLhrldT9LH7KjLDHUJdmU2uOQ/UiJjMX90s0LRZM29/VyidTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788374727;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=EgDyLYuxg2SG3uS8LhCnTeh5KOlhLxeMl3puS6JG/Dg=;
 b=VRbfr3GNm2p9n9OnoiQqihh0L1arU0x0YpS9B79F2Bm9WgYwpAFC5bFq/EJqWQ6G1lse
 VV9jdg4luOaNKZxDKU+fdSliVMLfRc3lHXG+NYKkeI9OUxoSUcKjyi1OP3iC8co7oXZ1h
 8T8KWTNtwYk+il3xkG6B/qLSxOrLsqBpvNqRBpGkEHqitmBbHqyAzrToS4crApHE5ufhY
 22JGctmKfTSoI3UIKBDimvhLX6dXp4+2uYc12BCqKxYr4nonLEL3fsmURgJ1N34e5IHgt
 tZIGV9qFCCWTtiRNFBPrZaW4sCfvwxsPMSY82mBWjaZiSJthbD3UbydUetB+y405tug==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=TFNaZKjp; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::1"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::1;
 helo=mail-oa2-x01.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=TFNaZKjp
Received: from mail-oa2-x01.google.com (mail-oa2-x01.google.com
 [IPv6:2607:f8b0:4864:30::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2630740CF4
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 18:45:26 +0000 (UTC)
Received: by mail-oa2-x01.google.com with SMTP id
 586e51a60fabf-455efbd6e96so402164fac.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788374725; x=1788979525;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EgDyLYuxg2SG3uS8LhCnTeh5KOlhLxeMl3puS6JG/Dg=;
 b=TFNaZKjpoOd4IP11t2ZTVkFR+i2BGYM6CxwqeCoPBfSm0UF2VObrZpxGC7obWwGL48
 RvnVyRlc0IoIko7YlTIu2LCCHqHsxnLWZcEju8NWNcQdRcPcJSz88fuguGf2/e5Pm5y5
 qOh3G5F1RCUvXNmktu+w1LDMqAaf9r4XCCZBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788374725; x=1788979525;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EgDyLYuxg2SG3uS8LhCnTeh5KOlhLxeMl3puS6JG/Dg=;
 b=p8VHJr3CGeTHkUT+UC4kp6vYXQNxooNraJcxrdyFMPgEmzqGJQO/0azcILSjb34p89
 mvj5lUDzxwQo6F8xoOuygWMvG7mVian1AnzXbOuXaXJlYbmVVjnVOvEZI2mq++30Y60D
 ft0kZhy492LGuIJSwJ6/ugcfSehs266A1Mt2aC3HVjU6ycFlOYEGTe9XXEs8o9T1oQRP
 H72XY9lWs2Ufi1aRZD3R60u2w81l4YY387hhB4YQ5R5//qQaGRZTF1Rl6KOFewPbqXi6
 e4b7cD4NBv+0hodgM6pfOMfReo57BsOxk11b3+HSJCJYH8QKOTc5QCviah6VjhsCWwhn
 RT8A==
X-Gm-Message-State: AFuF++nWKw34zbtFGzjq7YTwbH1j9+OpCRF8nyIl4dR0ufQ/MGmS8ekL
 N4oRS/swcjgMLz+Dfyr0ALhbQlxPMHTMGXnp7Qf9SmCpHVVIaZlEOW47h9rulWk9CVV+5pxNEMb
 Ksi99q/EPwyni9dc=
X-Gm-Gg: AYBFou0kZr9/iN/P06heVkMY/A3JXMPYsO+InfG9wrM8LlM1RdNUskHQNaznvJOPMoX
 rTm61VmMmg783THv1aYwV/zdncz1eQG2742G73X4dUvYOvSq0RaZGGgwlP9paf9fSHAcDrP19Wf
 sP1Gmk1nCMzrT6rV5J5L+Krt0xa3YFHAoCCam4t3+dgCzSfLv0A0I6TQaXB4betgjg1doEVqORf
 bPTxqCCUzyTsldhm7RdpLcon6ns96W5hpCTOW33OIPX8E0qnHoBwsmFEkxwFH92ohB5KLzgn8x9
 szSGTPybk3XvaQBVEyC19RsqafO6LoMok8ltTX97NL195JvXEtZ3pyzcqAHJQJzaGm2it+StAKd
 y55YWwHD2i9OhW9PJCa7lK9/oxt5OsTEAGhlOy72McyynhPMO7iPrMD+EPuuCppy4Gv+il3mxS6
 qJyrEkCzh8r3sFB4cIo9mH2tR3c59agQZyAteEZabIDMIBOeyt6emPC+ai5BnP15dqBQjuhTlED
 4d710B0o69W24Cg3KRs8r4lGMAH5jpz5QfWZwWhFf8n6HbUEh/JjVWb6+t4y/cDSEFhx3cjVUXJ
 AR2gs0fo
X-Received: by 2002:a05:6870:1412:b0:447:a816:9328 with SMTP id
 586e51a60fabf-46f857b1f86mr7003646fac.6.1788374725368; 
 Wed, 02 Sep 2026 11:45:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46f30baa0d4sm4794536fac.6.2026.09.02.11.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 11:45:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <e6962ed9-c56c-4305-8f72-05c1da14b8a1@foss.st.com>
References: <e6962ed9-c56c-4305-8f72-05c1da14b8a1@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot master / v2026.10 =
 u-boot-stm32_20260902
Message-Id: <178837472464.1800948.13161266651561394909.b4-ty@konsulko.com>
Date: Wed, 02 Sep 2026 12:45:24 -0600
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

On Wed, 2 Sep 2026 15:15:44 +0200, Patrice CHOTARD wrote:

> Please pull the STM32 related fixes for u-boot/master, v2026.10: u-boot-stm32_20260902
> 
> CI status: https://git.u-boot-project.org/u-boot/custodians/u-boot-stm/-/pipelines/1162
> 
> Thanks
> 
> The following changes since commit cc8c034e78eba6b2a3845783889b80753bb1af1e:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


