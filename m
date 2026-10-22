Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F08606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G9BfWCfj;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=NKmvpW+6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DF4E81246;
	Thu, 22 Oct 2026 20:32:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RDri-Va0eJGe; Thu, 22 Oct 2026 20:32:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 881B8811C8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792701138;
	b=WD0eB1iFgPCAK4z2MvMamx6n8NgS9pZsoNvnFXCuKQe+ENvMcR2rBGSR6Yfr84r2l0ch
	 Zuu6mt9akt2qkp6BZ4LOnFawkU/xTvWFlO0jytBS4zlQWyzVBZFHfBuLgGKYdG2kaQUq+
	 BG60UAT6/L7q+BS6DSB/z4vSSC2bjJDTcFPNRHivsKEjQg8BgaXLxzb0krh8Gr8QKgFwY
	 LDk4TSQJexgEf+Okfve7Q7QcPm7/2q47KU5RN0QIas64dlQxCBWr+ZmVH8jf5cHN6DR7Q
	 uApLS5WOdTay/aIda0Oftl2y3RYQYKGGl6sAv9mbtTFdCn2HXK7kCgqWxCVfZUETJDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792701138;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=S9sltRmXJMr87xxWl7tYPazswBmF6J2o9JY+olXBWjE=;
	b=ittFevrOAPfR8MB81ftI/agOHDKgjCd8e1AsspX4O2e3SonUImkZQHE28uESvupoQPcb
	 cfAQDtK9GzbUEHgSOSpMCm2mMr3kC5WahI5QIf5OHvdFSjnKpN69t9ux5l21TVpaHJgIZ
	 Kd9X/KQRx43GI4ECPoVuiZ28f9zx+im196huqWxF5P9lJkweVfxsRrKfT2THnwJK0t0Ss
	 zP79KYB1IsR9R7q6LLd8ouCXD2/ayRkZszZS7K86ydUnbDoaDqV+IaO/A2F33Af0i2Xy/
	 f0OIwcBjSghc87mcHqMcx3DYqfXVIXvFX87FCPZs2uL3v0PUWuKbenR9MsdS4u+IgUg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792701138;
	bh=S9sltRmXJMr87xxWl7tYPazswBmF6J2o9JY+olXBWjE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G9BfWCfjC+GCQpwnQ/kyEUajWjVVQJVpLatasE5xStQBd4t0OCEwpYi8mrLXcrKha
	 HrFE3R+Zozzk3CyNkSY7PsoURomdh2+KkZjsRclv3IjvI1r+9+11VmoBdZoqU1tdPP
	 GBKxvjdHT26PI6nsVkaaBCuU/5j6fHbgcY156P8HqMxFw779GPCK3WY4XyQa6DhuAb
	 rZIHy1Xv7pfWjAgCGJc3OIMo63YcQHxf9UqyuOdNREI/T6KVSbruoOfUenaU+YbTX9
	 r9roQ37ugpU038JnRn4bVlIdncf3zAXIt9JFRUvYA7SL/QiyNyR16JuFJExkwzSg/s
	 mkk0ZFCeuMCpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 881B8811C8;
	Thu, 22 Oct 2026 20:32:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B8E303A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 20:32:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AAF854076D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 20:32:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ITaXDLCnQQib for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 20:32:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 725F140763
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792701137;
 b=fxfNs2GfjTgqKJO1qJ0qK0XO1gMfayiYUnND1HiPeMO7lEIRVQUCwLaO9CgpNknRDrHC
 a7XbtGcWq+U4XMjqk27jpp1hUmtjzjpMwqqteL2GA0IWYz9herexlY1YbZc0NmhIpY1QZ
 YjCcR0KGN+oGAaCRxvAjy9Plf7CgMgdiDRCgdil1gBAYjSiqPsnCMNMcvPjyDuMKrIhFE
 A8PqgRz94FNWWYtlEJlQMnWg4WIJmYuRY/h0zpMasWJ3BPavZoYzAg6zChlEdUjFZWtP9
 b2Xp4XiUctqfzZnRBsyWyiCYlEiTfmQrze8SG0wCEEoBl8WEAVMpY5GqkVU0sA2h4rw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792701137;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=S9sltRmXJMr87xxWl7tYPazswBmF6J2o9JY+olXBWjE=;
 b=VWtq1fDUPwNdw7EPkKr78DWnU9iLgU6qj/nkx2ylHfparbNTeJX1pLHqHNi0QfT98lW9
 EpeLpmU+R1CP1Mmn5smUjw209fPuh+U8eD+Ka44FrSueLue7wKggvu1lh+gC6SaFVDgIF
 4nKCtzrGT0jWZU8Nxm5luIGodvCZC8kySu3Zjib9ERclieqEK4X9ut6I6q8uydEzoKUr8
 3mGlLWK4raJhnurKhTt3y9k1HA8a9S6NGFsDcCW7EY1VM87cTvFAQwmktsuzllaoPXA4F
 mHFNtKn6oiuD8/31nyHTXTphBhtNQFmOVQE1ow+U0+ZE/DiwdJojpHrGt6JWjlrn0qQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=NKmvpW+6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=NKmvpW+6
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 725F140763
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 20:32:15 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-706113e92f9so134772eaf.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792701135; x=1793305935;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S9sltRmXJMr87xxWl7tYPazswBmF6J2o9JY+olXBWjE=;
 b=NKmvpW+6WOGr763GM/T9XwkY67dnBODgZrO67l6LDqB7KF/7L+eajSJNPyQ72blx1Q
 l4j29vOuIQdPSnDm0sD+3gm2KTUUZ5NxppaSKf73aIwsf7wZKjTav0NTxZxlwt4ZK7ru
 v2kgYKRw233QJMHBh80ZE28j/uktzSvU2mJOQma51u3aK/7YlEXq4Jil5y4gUV9N+AxY
 m3QTEFRKyiqGd0cwb/+S/j1fUPmXEbu41XRTWTXilZEnemXd8YQ/aPRVij7V1a0SkYls
 MegtYEaPq/PufQVhkV9kBPRBi3emuohjCuei4YRTaccjK3qw0/GNaj6Er8bKJfR94/PF
 xCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792701135; x=1793305935;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S9sltRmXJMr87xxWl7tYPazswBmF6J2o9JY+olXBWjE=;
 b=iMDZbkYpbCt+fUHmzD+1B/+OcdGCsj/tQZ1yXuhynw09J5akhr/kZI11zQZper1mQ6
 GUy+sd0YNd69ns1VveAl7isdYKkDcYXwl60Qf9q0NqFJ+gMBjwXqU8jYwRwdD46GQASH
 4//p7d9srgfBCrZTPYxbOTYh3oQ2YN/Vt7qaPKvxluL2vLfTlzVoggMfH5Ye9Xnrq6O6
 3Jkg752AOTxpVGv6996Vk576kLCePTQ3OmZXnkDKzTKEi2bIKgH/pdMG6eK/MZhhc460
 i7Jco+7oykkPWmLHkOOoSZq6eGoFD34fh3rkTHwXxzeH+dqyOvyeEOidpk2RxDeSPZ/0
 Hajg==
X-Gm-Message-State: AFq9FYIF+rG45OzFAyMp7BLiDwihUSK3tETh7NMf2axfbCb2QKeGypFM
 gpm2Xy8l2//Rj+D5a35i2CTMv48bJy1EuesqUXAWyisyqrjlTvcG9CAnxG7WAhNOz4E=
X-Gm-Gg: AYBFou3m025f+pRZ7vnaWVPBXz+Mru/b8P9U2lHH6Wm4nL3DVuRpwIDVfnumDNeOEhy
 aMa/NTQ/yXXGZyI0Wy63NZ9K3722NaQKi8HNR2jZa3mdSs/0ss1vnDml/MvvzlCKxNhf7kXrUOr
 2QbTU5VNl2k8a7hfvFGBh8XK+UMYFrFJMAAaPygO6FX8ZCpri04/grCh7XxfuRc8HrPyQRNGXo8
 6TVYm6z2Sz+0ls3OOoOWLsIVBE+T5WjHWXm22Rrl3cWN7UrLRzqqQzQtGvyGMm+AtgpcAajRaLk
 yHiKCBTSQzpWyxR0QPs3/cMTlHiW56/7HzFq0yvHEs9MPat+eSjb6SOERwcwCZS0LzbAENdu6UX
 hqGNv+msyLWnPN5w27d9teDf/uUAzwQ3kkt9XHZkQgO2eak7ck1Q1L9MvkUTdJxndV35EmmyUGs
 J9sD8i+zRf0VV2J0qiZse3k2YIZDaM8TtqkDxCkjTU0kXi/QvD9X3Hkvr5/AF6IKxonljtgE6Z5
 OILXSdzJAIPJNoU8ch0NsMayXBNnrzrCtRr5y0A9P6bpw5JgqgatsxL3BiWvw==
X-Received: by 2002:a05:6820:1381:b0:707:7495:9458 with SMTP id
 006d021491bc7-70b889a0262mr374958eaf.16.1792701134951; 
 Thu, 22 Oct 2026 13:32:14 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d0bd:a587:44ef:f6bb])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b8b2d48e6sm162095eaf.10.2026.10.22.13.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 13:32:13 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Chris Chen <chris-qj.chen@mediatek.com>
In-Reply-To: <20261005-mtk-genio-360-bringup-v6-0-630f99bf3ce3@baylibre.com>
References: <20261005-mtk-genio-360-bringup-v6-0-630f99bf3ce3@baylibre.com>
Subject: Re: [PATCH v6 0/4] arm: mediatek: Genio 360 EVK bringup
Message-Id: <179270112324.3711947.12685014840770204870.b4-ty@b4>
Date: Thu, 22 Oct 2026 15:32:03 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1001; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=XeIcSsm/yf1Bq43DHbr/2ZuGwVLz0YjG9CY8w4fKcZI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2nLFJD8VeMYSaZZGqsYqlBgeG+GPxN/u4VeoX
 mynqRpVsoGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatpyxRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AptwIAIVVUfBQ6CcU2jLeuj714+0HvZyYWrgQfAJLHEQ
 55ASFj/W+/jkn5GLLQbjSH3lmyHnRP3DSiNbt7ryhM87G2QhZayVC3MOtIh/D5RMZfalwE6Z7LG
 YxM8qelU81sXnHW274hNsN2FFVWNVp7vN0Vq1qqggW41WE20SFH7DIlWvFKSL+vQ1GIe0NTiPYr
 EpT3mLR3YzJtpjjIXbCFWOeBgOcZn+Urc2VxtZUgZw0QXoRTE31gtONYnvvw4QW2Q81beqHJYAD
 7cKMuQqcvJZXBWqfW8d+I6zz/Yzxnv9JhH4ravzt9iCniklKxgOGDW+ySmJChLo4EMpQi2UywTv
 oXRo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Mon, 05 Oct 2026 17:07:46 -0500, David Lechner wrote:
> arm: mediatek: Genio 360 EVK bringup
> 
> This series is doing a basic bringup of the MediaTek Genio 360
> Evaluation Kit board. This contains a new application processor
> (MT8366) that hasn't been seen in U-Boot yet, so basic support for
> that is added as well. Clock, pinctrl, net, phy, spi, power drivers
> to add support for any missing compatibles were sent as standalone
> patches.
> 
> [...]

Applied to mediatek-for-main, thanks!

[1/4] arm: dts: add MT8366 application processor
      commit: e5b2be858da51ae7246fcab7436d41a452daeee6
[2/4] arm: mediatek: add MT8366 application processor
      commit: 92866153d9cb2ae81ea7058b19e75b019cf2043e
[3/4] arm: dts: mediatek: add Genio 360 EVK
      commit: 98cb8a16975b9878e2ec24a84b01845bc02d7f6d
[4/4] board: mediatek: add Genio 360 EVK defconfig
      commit: 904d47fbdb15f185d443d57af7357c17e55c0874

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

