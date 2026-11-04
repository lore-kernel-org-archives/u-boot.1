Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0156606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oXzEMcB7;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZE0WcoGC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA001605D9;
	Wed,  4 Nov 2026 15:01:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CvMKL-EnvMoo; Wed,  4 Nov 2026 15:01:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 013B1605DB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793804506;
	b=Az7M4NvEoJX71SWuJsaxelzJJspsl4Q5VUxPzcZIXNo2FC+PuEaa4wQc+TezrbHtP0HK
	 B7wOMzp2jikdq6de305QI5WZaGAW0KIGp2/z54RrMvb+HDVhIGkAv762sZK7+Lytl+ZPZ
	 ccOd6bo0la6rrGoAILl84yQBET9KqYnc6mNfma5ThggSeUomKk5IKEqexR2oRqeW4Avg2
	 hf8Dc6eKDu8FkZM6WfEtvNfFrK7ZU5TgXPPIYkSbFYPLIVa0Yb8tMQH0W+ElWm24qqZaU
	 qvttO1B5P+E/zlM433TXRccZZ9x79EhmEm/OpVUFDyz0H9NXXmeNEYnZg68wp8LBjuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793804506;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=tgt76ybQoXzv4oBIQaFk27M/CrdZ21Nw9H+sQ0yhgcA=;
	b=RPv0IE4ifydGTmeVbrCL3pQO8bgYFBsfrt0YcRrsn7A80LOAx/4a9QTQ4m3E8ZRsqhq1
	 2B8iGGFRrQXTHWB578Yr+pqkhKjolmbH2ge6GemRWTTuwmXBS/5xNHZZTvj03WgN+9O6f
	 ZWk+doDyykPYdqpcaA3hf3t2VcvrWv7YOr4NX2fvMWHIJR+yyoX4liP4wtr1io+gItcq5
	 nuF7yDbLD8kDQMSAKSgVtA2uuo/yeF+LxjgN1SQvB9Cr9IibcooGlKNXHn60LCaxqd+1q
	 h8aAFn8B3zReL/FPgMhfPswP6iFPCOg8pScr161QpjVWUfydidULPCB161qGuxFo5xg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793804506;
	bh=tgt76ybQoXzv4oBIQaFk27M/CrdZ21Nw9H+sQ0yhgcA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oXzEMcB73klHGy9VGGziTOG+7aRFyF3dTjmrkbDpKH38FGNeSLjDPK8dgEgTmQQtD
	 nFr5Tlrprnv+E3786WT1mU0jU7HzGOvjTUcemeJIVzpL4tIiaI5Zlgf9m1wFBpEdjB
	 uYNC/FN3jYZwTDzJ6U89CKuZJPL9i7GKlUyWYav6YOxEk6LmLBVLZK3U2FVdwgZh73
	 lfdO/+QimzJOIuyYNoOywDoLhukU4oGJ4IWXh+R0ywLpABFJDEaHuXg3pgwaWMUCeT
	 Z/YBPr3LqSNZSh/AShbqzqxCOfy1S80QGN4sfSPFLKcfOH1IRgeM2zA3n85EngaGrc
	 0E3dTIarbCRKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 013B1605DB;
	Wed,  4 Nov 2026 15:01:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C682A14
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 15:01:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3278C80DC7
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 15:01:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pklMNXYN8jLV for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 15:01:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 74FEC80D16
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793804502;
 b=WSRtVJY68lqSfUnIm5fbcldUVk8xsUWo9DN86xkUYT6oeUJ/M0nifwf98eztRlCf2YQ9
 JqNak9sbOmjeUP5f7ulAwWoW1H4swGOga/KGnhHTqCpiZpw3w4JY5iWEr6Iiz54ePoZBj
 uqXvwHnL8DA+r0BR825xZN+k+dVibepax/KIwRHVZCJVOQXLdtsdGHbfiJdY2SfxJ5LPa
 8KqNS7frWfsv5+uBeWn1r/O91Ww4Yfr3JFtW3vWfRfb/wROvYfAheckoHOeZrRZHGl/TF
 mqYuIWu073wzx868+9dtscq9rpUI2rraQyWe2hfQFQgMwOwMs04GDL2C390/CfWAnqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793804502;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=tgt76ybQoXzv4oBIQaFk27M/CrdZ21Nw9H+sQ0yhgcA=;
 b=IrYEevp27Gqu3e2WQeq3vV2TqRCo5V/VNlq2rJXazXf8vusG/m5ov2zPmWGPgUYoanIe
 +m3K2EC/CT+wib6YgmyivoS6ART6bYipyxLpcfkm62KBcib2S+nlcJc7pbcjMYyz+CCjL
 EjWB3MAnQJjbrXyHVeALVnorzAbLiuOdOUrt2yyLou0T7sI6OiCQiBIR9HOwsYsEqhjmi
 l3rG8IhoGUBG2Mq4UGf9n9k7TOqEC2GishTDcRBbUZZEDCzDXmH8auDOINWgbESwsFFPW
 rRqwp7vT+ro1McU5TZyuuMfBfJuuceOU9FXs6WhK/l3hqwo+Kno/EEjALw+lx9VXKZQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZE0WcoGC; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZE0WcoGC
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74FEC80D16
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 15:01:41 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-70b875f6f1fso723995eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 07:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793804501; x=1794409301;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tgt76ybQoXzv4oBIQaFk27M/CrdZ21Nw9H+sQ0yhgcA=;
 b=ZE0WcoGCYfFWWT7ksd85yjC/MZk6s9lkYuiyMOYAypJgTroRPEvlpgsU6kZ26BoVFt
 9OZcQcS+igl6JKEAHmeN6fq6snGpiQ5ODezY8nr0fUY4rQaFK7IyKoEpdBfRUiEd/Lal
 aWgrPaf8rfO901PLAF5dam5wbsENILC23q9rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793804501; x=1794409301;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tgt76ybQoXzv4oBIQaFk27M/CrdZ21Nw9H+sQ0yhgcA=;
 b=bC+bFrILDH0HG458NUaNZbi5i9sKHusChHF5XdWy5JRder3qfpGG0Mkewl5aD9GCE/
 wg/3Qq2iYGmWakBS4KCuNosu3fVNjXD+WmyVmGyn4b3nCeP7axpdwyTvCqWPYIPc8WCu
 NMSnhblsvSONO+zv+zbs58n+ntghVBnSA4s8nyWCyWOrImNFZea/QlVU6DcJTbfRQ/0j
 KJ/iFS197HmfmDSIJK0fi/eSL2SmyM16gKabATRJNHitczYoeNFg6KUU/eIagx3Dphwj
 HbaBCIQVXjF6Aqn83cLAO4PMbbAYM9yV1QzjYCGfRll3AyJY0oIWW03vezAaAi5r0c34
 uGNQ==
X-Gm-Message-State: APuU4Z+0HOmUymrSl20AhfFbpZR7MVuQHZOR7j/urwRyjCqPRDmuG/yB
 zPcU9w0YA7xG2PfnopOzNng9odLwcwrEPdS3kzjKc5Kcrir59aWAk3pNwXIplWTMNPnQ8LmwuOG
 woueAV9eNrPY6
X-Gm-Gg: AYBFou31abU0QdDXTiy44pVJjOg0NwIppbBeGBgSx1ArbpAwF1teofiDW0r5bvRYxUz
 hyvE21ucm5p92JkRAftcsxAHzQXgRve6h+UUy443cdsQUZgMQZxAnLpuXp/C+3HVeSduu6VbwlM
 JahnnM6OXCEgKo0TCFrFwY/osl81zfiZz6hjgoxUmO0LijQ2kr4OcfKA+pIqzuxv9hRkaEDsWbF
 D87lX+rZk4p1V1OJBqnFTfSBzucTLeGlMohasdworlyrHNNdNY7D9+HnBHxisFgnJZ2VGUnnirx
 RBq4T5zkmlLKNT2dDDWprnfCAY4HJUcp6VkU3+JAJpE2pV7RIEzhJ+8z3RovQiVsSKpe3iLu+md
 GPI6O1amg40DEawkKGCY8PacYfFMjQsHuR0KDDByduiJOsHqEU7TRjL4i1jfkvPEriBYBJGSXhl
 rmp9+ITsQ4H5RGZfIzT2rCwqVSyex7TFSSpEvthtzQyHE7Oa0nYI9yoT+W5YDjYgbxSR5jeGaAb
 FHtT9aWIknfW20a9nJh6KRR9ld/+JwoH8XXanaq+/ZMy1ZunzicxOXvYHWCbiUTueww5MV4HNcg
 SPag4dpsy26YvGHFruc53Bo4wfPTecvKZBOd5UcU3/vWJuBHlgsdA/B7AT1yV36y4yFO7Ny1j3e
 n7fR+hUL1HhFGd7TZLuRlxywiZaC5nfFSG2O2XUi9ohjt9U6HHXRaiAphEmLBw/o+3xx/ZCS3p+
 9A6sVC+3ZLGzrtg9IKWo6Ns5UZj4oVbA==
X-Received: by 2002:a05:6820:61e:b0:6d7:aca3:bba9 with SMTP id
 006d021491bc7-714f29ad107mr10428050eaf.38.1793804500887; 
 Wed, 04 Nov 2026 07:01:40 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716c0cdb22dsm1873859eaf.0.2026.11.04.07.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 07:01:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Thomas Richard <thomas.richard@bootlin.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes?= <jeremie.dautheribes@bootlin.com>
In-Reply-To: <20261023-mac-eeprom-v1-0-f7a5817d455b@bootlin.com>
References: <20261023-mac-eeprom-v1-0-f7a5817d455b@bootlin.com>
Subject: Re: [PATCH 0/2] omap4-var-som: extract MAC address from EEPROM
Message-Id: <179380449999.1119852.4783408333815580445.b4-ty@konsulko.com>
Date: Wed, 04 Nov 2026 09:01:39 -0600
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 12:10:07 +0200, Bastien Curutchet wrote:

> The MAC address of the OMAP4-VAR-SOM is located in the SOM's EEPROM
> under a Variscite-specific format.
> 
> This series add support for extracting this MAC address and fowarding it
> to Linux through the device-tree.
> 
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] omap4_var_som: extract MAC address from EEPROM
      commit: f4feca283c3992461702dbb4fb166b44396252dd
[2/2] omap4-var-som: forward MAC address to Linux
      commit: f5df14cb949cfca5c6b175abb8d1ac9210b911f5
-- 
Tom


