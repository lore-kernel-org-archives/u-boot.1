Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A79606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vM/kH+il;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kVpm04NL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C4B240600;
	Mon, 26 Oct 2026 09:27:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BDmuYOOQ4Jt6; Mon, 26 Oct 2026 09:27:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A5BF9405CF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793006820;
	b=n3Z1N/zpXg6QQpvwCbTVb3XkovVeKTSzNkrxB6kB06LyRXfafBzNrkJZ3v4f89yWqzyf
	 cd1oxz6EnFClaqx4yHqJ3vd/TKMtl9p9v9fUURHCEXiWcSTfZggNpDgY3wpseLwUVXcoi
	 kzwYxk/RF+oBNJHQbvTmnEMuRWoRq9ywvu7lElIV0WX+laR9VOYwhB7Rz4IE1EVSnHoG+
	 iWh8OBTlyTTX0wo+xVIE7okhOgMoFuJfZknXzGmOXH5RhWEuhj4/yx99MsNWMAyp0mDoD
	 JYuiK5cL2MyMj6boF6RGaYt96dBK3H6dXK/XP4oLhq2vo04E5UIxxIDOVE73WOA42Xg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793006820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5wqWa/H3ybp1tjzTOxIwpIKlZHzqghndJdEiIg0daYY=;
	b=ZzAKV17lYJTQGlsmUXCe+dhQ6s6mN6DH+bmKVYMPMYVzw8Cz9DFy+1VdqSGdoG4QrAEw
	 OoYKaACuH1OUU8lpIdpaW6MNG0tL/0NWVU2ljvlF6s9fRJWSah23sxN/7vH1vXujHOv3f
	 xj60XjkwPE7Y2Zhh89Fn/x92gc6zElbBAUdSGUm/KD6qtYnqsG/4aov29p2pJLyn/rAwh
	 0pzZzFPimmWEmZgrSkDOrpG5fKx2AwXIvUTfFF6fvRa8WU9yofapkr8NEWMeeB1QNR8Px
	 jpCd9ZIgyX1LO7Mhe+YJcsMtA25EmkiaxU8SE3i4XsmzxA7qEoy8PyzG5h3Hso34Qxg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kVpm04NL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793006820;
	bh=5wqWa/H3ybp1tjzTOxIwpIKlZHzqghndJdEiIg0daYY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vM/kH+ilxlE8QGo2zXt7U01h5Tr6BiNgJl8M5Oh4F0ubB3d+hReXBnzAUw4J7LrvT
	 ijAHdaRZAdp8QlbnQU8tSGfhdNMd8dBCaCo/O6cM/2873wTM/FjlYxfEgJKfljxcai
	 bOX/8TDYdW08MQRkHI2QxF6Xh0TRX4nLquFz+TpJ8jACgYQoBIVj8JGY3IaA9YA0Om
	 DXQG3Be8i9A/dMFdmuoleSx7EHqI27gxMDjYdD3NdU3FUSOvhHCRyQZ9L9awD8Dzno
	 U04Wqkhu+fmOLH4dNy8HEFGF6i0zts2zfJmCnl9G+7Q2WC0ZdT54+JQkiW/CxXH92f
	 0zuYbhYsb3Mhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5BF9405CF;
	Mon, 26 Oct 2026 09:27:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E08DD3B6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:26:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C67C3405CF
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:26:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jWJZaGqDfNXo for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 09:26:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0868A40593
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793006818;
 b=U4e2utpvyzDN3wcWbuPPxyZVWXd/3Q3C9mSbLyH/FVdcYf6qkfV/xwHEpSj3df5FZQB8
 iPrG6iLNTcJuaxBIkX3v4Se8DhZYGWFlPSHPgd/MXwR6YHtV5YbOaYJi1qPTXtSjzUCiq
 +AACK2RDsbAUYGvNIUXmyUb15Wp01+rBs0lVyual5GnzG79e/tN5cCcCyMZ/DtoSmEZLo
 3LCSP6DI8lGatCOSkjtovOYs9AMwGlN32w0E0Sjo5UjYLyHhV9HIirK77evaJvS6z8Jrl
 tGcGtBacpJ7WJ/PPzOp/M22GkXOJY5EfuI/okmUT4FK4Icp1lLD5aNEv6NwAOxfmrhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793006818;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=5wqWa/H3ybp1tjzTOxIwpIKlZHzqghndJdEiIg0daYY=;
 b=G2fCjMal394h//680aF83wI+qU1KcV0ClIJP4bVrpCfzfGImBb/et0a0a4fR6XjJBLuj
 IcJFMLsutlXf/dXpEjf9/q/wKVmRCAb3hDTIvVOnszVo3SS6AmMdIdLrCSV1yn180+vD9
 YuWmA9YKbmR00hplSKqqEPTe8XBNnt43dE4UoPTjJF8jzC2aZZzAnO/GbllQybVbXmW2e
 x5Zqs0pnR2f311z2Bb7jWb18JOQDBz5fHJqdBma0DG8hS8RxpMeI2Vst5dfnQsNVJCmhr
 VGxc7HaTZXSrtmK8/VMWMVtEUllLBFalJgQU6Hv83f3xeEeOHexhpwXTaHPsezhkMZw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kVpm04NL; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=kVpm04NL
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0868A40593
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:26:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 57485601DE;
 Mon, 26 Oct 2026 09:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5821F01825;
 Mon, 26 Oct 2026 09:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793006816;
 bh=5wqWa/H3ybp1tjzTOxIwpIKlZHzqghndJdEiIg0daYY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=kVpm04NLv/siAequS7euHZmy1biIJCz8tJuYE9FJspJsJbV9pwNQi24+AGR3CKLUp
 aKGvoP6to+BxVfYpD9s1u0ZP34RW7YHDqaAETh+4dwO/9gu0qdBauBPWYpYeEi766b
 Fh2v4mG5V0dG4Zi6n0buCF6bSUaEfWUbJm6iSqAROdXc18m+ZxixFfvADLATvdOH4W
 4Q5WC8Ticfr2r2kj3l2jBYsJ6CAl3RLwZy5WWoMVcqK/5lhsHLmZEYlJ2GKMVkdjZ4
 rgoBz0CkrkEBNqERNz/Zj2uQ6oYiOnG774cjR4/uJdrlhimFUyjsh8QVVAFjag8Nap
 UWQqehFxvAtJg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 u-boot@lists.u-boot-project.org, Kongyang Liu <seashell11234455@gmail.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 uboot-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20261008-dwc2-iddig-fixes-v1-0-24c302b8953f@foss.st.com>
References: <20261008-dwc2-iddig-fixes-v1-0-24c302b8953f@foss.st.com>
Subject: Re: [PATCH 0/2] dwc2: fix debounce timer usage in stm32
Message-Id: <179300681357.10210.11892552414718223348.b4-ty@b4>
Date: Mon, 26 Oct 2026 10:26:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Thu, 08 Oct 2026 17:37:06 +0200, Fabrice Gasnier wrote:
> Since upstream has introduced dwc2_core_reset(), commit c5d685b8993c
> ("usb: dwc2: Unify flush and reset logic with v4.20a support"), upon
> init, the debounce timers used in hw to filter signals (Vbus, ID pins)
> race with the driver init. This result in the wrong mode (host) being
> sampled in dwc2_core_reset(). Then it polls waiting for host mode,
> that is never reached, because the IP turns into device mode, during
> gadget driver init. When it happens, below log is seen:
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/2] usb: gadget: dwc2_udc_otg: bypass debounce filter
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/d08afddbae55e100b8b0e22dda6f77fe303dbcc8
[2/2] usb: gadget: dwc2_udc_otg: wait for mode when digital filter is active
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/4034c422a85f62c7aff58a5c8f43bcd59bdb2c6c

--
Mattijs
