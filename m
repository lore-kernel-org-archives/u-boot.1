Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE77ECC6B2A
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 04:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C062814BF;
	Sat, 17 Oct 2026 04:37:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OX56ZxiBrUvN; Sat, 17 Oct 2026 04:36:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AD65181679
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792211812;
	b=EKVL0A3TBqtYwG7H/2Rbuy3mAYudarC0gKPxSwtQdRbrniiQ3frv3rjldw29si+mhbb5
	 az1XQLFFGyFjpXKcsLUC2NyynLlYABE8odBHjVXn7dGiEGh/VTjIE9HGL2mdoRirTBb2Z
	 BtatbzNCL4lyCD8Y/SCM8Ql463bT7YUxP5N/JCxEsIe3KZnBjLXx0g6ylCv6IKNI/siHs
	 73jt8Fa+nQA/HUaq+Cz0UYq+yGAiqu2lv9uD/TtmhPbtZohaX6gBKWYAarA6+I6c7D6W/
	 01XrKJA/eegWSfSLleSBsZ4sEgpPlGSkjKt/45CLMJgEirs7zV2h59KoXTOuzcOoF/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792211812;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3OGuH24S+5lYiwNQTa1U3c/C6oj0JW72F26FUX8MW7E=;
	b=PYR8Xd9c/qyRQHWyGArZjmIvckFlr0lJ4zekc3eCN5HbzfDkAngEcBZST2fRqaQaShFh
	 wonOtxfRrTwTJJgm9KgLuiR/qckufxhdGvHz1TYXyfVzaC99JbhwMxyKAH7CVW+RpIiCY
	 7/o1077f3GU5hJO8UQCHY5+Z2mrhOa8nxzaHj3pQvUK9eJBr3Cd9aCvNhKBtf0Z1lzifZ
	 8X+1cbdm7SCoKECfpqPEMw+tSOKNMHGb+XccRLdQm0Ley0vDQvNszQfHb/eWgk6dmcPhr
	 1MDO4i8kVPg+TrFFnXoUeWQ2aMHwtWdyBOv1gNXqY67YlLZPXXjldAXV70zEd1C8qQw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792211812;
	bh=3OGuH24S+5lYiwNQTa1U3c/C6oj0JW72F26FUX8MW7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ubmp86/w5dz/chNIQpG3/cWsjMBpk+DBpWn0Pt0oLpcNwAhi0ybmEMHPhKsyDyFCA
	 6gjVsMQFf4+uKRlpD4/MTQuzXEsjQSS6wTANHy04YInNyAO5ZFBc1vWJsrtHO4wtFx
	 cbCL5tyuTlRJABRa5zpa1U5S1+9c5u7Afq0IS5xaD7okzx77LvatXjtjAiilPBnHQ9
	 qXVjOQQZ4CwR5a9eu5L1LJs5TDEA1O+YXBqG1pnvOvSCnDgiEKNrRtNjUUQ1TUbfVD
	 nGT4+StwQtxJtJJL82Hlxbdpd31iC8hyhNxnq54nl2kTQZxeA79MxnZ8hjUKPtA3Kq
	 6m/2wp8xhY/MQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD65181679;
	Sat, 17 Oct 2026 04:36:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AE43DCF
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D5C9C408BD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L25EevPvEIbr for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 00:36:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3D9C64022A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792197386;
 b=a9czPoOeNQyWmU5w7FoLks1KYryNuH6BH9lTm65UZmHw80cPol947UNWYMGFe5H50Fnj
 7dg53JN4aBpcsAA9JT+XNRzm7Xsp4EWWGySSpBrIlHRc0rJDhkVnYUx44mYDnon7DHdKL
 wuL/QHy/ew/A1j7wdIsx8wW9qmcxJ/pmNZBWuswQviExAS1Yt5OnipstbTOfCABi1H4Ua
 y63AliJ92ef4ms3h1byWEPv9EioJwqnqAtyQ/tNyBC5dy9YsxQQONs13YCOPEAgPJlGQA
 c080qPsyLtrAIZgO5OwOt21e5Zi3JnJEKxYstCw5c/P1vZFCqXxxHfvSXPMRb19X8CA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792197386;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=3OGuH24S+5lYiwNQTa1U3c/C6oj0JW72F26FUX8MW7E=;
 b=npoWG7ovHVuFrGd08QXHIEMGfB21yDzJLDxYCTgc0kj/14ydvpp8tnX+J48AGrrHz9u7
 T6dX3uJ2xsfatFZ2x8kRTIxGCZZIjkalkfvMmPrjvkS0BA33sbDD2y3en7BId4dk4cE9b
 /aF1FX1LEAwDIBhPSmsbopFN2TZXopwY1wq+aTrcNJjPhg8731701uawNKm4TW7gvLVpH
 oIGwYUhJ21TZQZcnONB75N4af7fiA+R9kzjqaSa2sSZYVOR/doCIgGvOFTwkrId0q+UeL
 dyOhNxXDvfjIPVixziGiyC9xmyporkTQY2Q02bhpxiEdf5+EVLs2KgFQKwMGlLoF/rA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qilnnxZw; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qilnnxZw
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3D9C64022A
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:25 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6deb848ddd7so344882eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792197384; x=1792802184;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3OGuH24S+5lYiwNQTa1U3c/C6oj0JW72F26FUX8MW7E=;
 b=qilnnxZw78NmagDh05PNufBsBgQbXCmCS/WDkIKAd5UM+cfPQ/cHW9LT4dnSp1XX9y
 SsWQ6E1Tk+EGBbNcqcIgZQsPZbsHHOMh1ZDO0kfabzBZ4s3nlWlKiFe1sM5GJhrIIaa/
 J7o1uoxlMGXyOqltZbJJPR9A5U4AwF+0T+K4GvyQTOZ8LrIfCJL1E5y4m1tp5Amx4D3b
 nm1io6BWcmgbHLj9YQe1uMEYhTMit+vXmrvJHHor0P7x1SRpVBL8n828LY+/ZLQlIs2I
 mgcRgNQAGzrZF5ylr5Ism3YXguEx59bUNU24jwJuzDEGaUB3sNgURHG1kskYO+cUb84p
 97ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792197384; x=1792802184;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3OGuH24S+5lYiwNQTa1U3c/C6oj0JW72F26FUX8MW7E=;
 b=M2ypQdnm/kM2Gl2GILLJ9mRo65sSFfHgnkrXdxT1IdXrj/JAmGnGhh9q8OY1IwsYLL
 /213ifuN09T9zWSYd7PyAa5J14kcE2Si0ryQr9UDBE/+KS7eML1Hs9RX7EbpuaTXVanp
 Zwhs3/IXxskLhBGHYT64ld6K24XecbceyM7gnWHEur8Qcx87xHXPIf51B+Q/BG+/ZEyF
 b7jZyE5Xu5oWbpjLIniVifCDaDVhA6t1OgapToUY4/HXq3Qpkci7NqwXRd4Qv7LFxB+P
 ofhy/dKiPYqBIxVkmGKC8TDUMDZZTnymIFk6F5w/fooKT07YNpWSUaF52l06MXGl6qf2
 WvBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3ivc/lYeDx+yMdrtG30bAy5lJtIWziFZlRVDzjP6ocVRXxdadsXt9Wb2rROd/Qsvf2lVza+E=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ0n1fr3SfoI1tlckXqtpTsMq0aPe36IWlkj9rchRkUcJ5yaaC4
 7xhidYdC7qj5Yl5Q5RRXwtOwov+40Ixk+B8nlP46ZwIqvVoBqm91hP2r
X-Gm-Gg: AYBFou0FU/3DzLKDHbaNK9EsLwMtrs7ADbhs7DeDBLpdqQWTdNIT3yF3JzYfLfM69Qk
 wbCqxUDnnzGVgTrxLJTsNxy0EAFXrlhvArpzLwryjGJPHi69erysX5Oz79LZ1HChPzoLyG7Uz77
 9t/9QcX8Zha6JPebeu0nsbtihXsUljYOvRo0EoLwRzwav/d0wrp8ZHstykB3GopqLJiSazzDEhv
 VR09hCOSS9inQ+UwmUWWVGd81wz6UAOa5813qvXDLSMQOc1j/1qOYKxWT5hu1fSFqCx0FdGQ/OU
 gghgCxSmkiSbMTQYsPDDH1zKOxZcEcoxbK4qIsxBgfKNzrnWEmpQVqz/Ex34ORPhWbGqRskRSG+
 wqTmr+AdrZDsuNZx+wR8J6cBEysbOAKegUvJnfDbvPCvVH2qB0oG935IDPRp3HTNZgR2BbiAvEt
 plTg5gJlDlDLVNM05ZKGAi3+OvKD7QMPNwvEgQZegcw7V0LPHXGoOulXDzCf53UflqVEH/sySsM
 bX1yHT5LySRvp6ORBNwi1R8EHZH7qNZ3dxcPoDpjklldaaXV/7cWMbb09cbky6VgeowL+3hKL6h
 lVnYbnapUDUUTDYAEPB0Cgr/p/DBgVHswECUVugG1Hbl68bdThYHgwcORLNsQeUkqxWRAr7pV9g
 5ul0pf2+u0EEPyceO61bvCA==
X-Received: by 2002:a05:6820:a292:10b0:6d8:57bf:57de with SMTP id
 006d021491bc7-70357698816mr678718eaf.65.1792197384184; 
 Fri, 16 Oct 2026 17:36:24 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a73b5b4291sm2745091fac.5.2026.10.16.17.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:36:23 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 16 Oct 2026 18:35:29 -0600
Subject: [PATCH v9 15/17] crypto: allwinner: add sun8i-ce AES driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-submit-ce-series-v2-v9-15-c24e64daafe9@gmail.com>
References: <20261016-submit-ce-series-v2-v9-0-c24e64daafe9@gmail.com>
In-Reply-To: <20261016-submit-ce-series-v2-v9-0-c24e64daafe9@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 u-boot@lists.u-boot-project.org
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>, 
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Pranav Rajendran <pranavkasthuri@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Alexey Charkov <alchark@flipper.net>, 
 Lukasz Majewski <lukma@nabladev.com>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 17 Oct 2026 04:36:15 +0000
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

Add an Allwinner sun8i Crypto Engine driver using the same directory and
driver naming style as the Linux sun8i-ce driver. The parent device owns
the shared CE registers, clocks and resets. It also provides an exclusive
task-session API which centralizes descriptor submission, per-channel
in-flight accounting, completion, error handling and reset on abort. The
AES child exposes the standard UCLASS_AES interface.

Support AES-128, AES-192 and AES-256 in ECB and CBC modes with
software-provided keys. Use one bounded scheduler for both one-engine and
two-engine operations by selecting the lane count and deriving serial or
parallel behavior from the task controls. Each lane owns two fixed banks
of ten descriptors, so memory use is independent of payload size.

For word-aligned ECB and CBC decryption requests of at least 256 KiB, run
the AES and RAES engines in parallel in SPL and U-Boot proper. Each lane
has two banks and one active-bank index. A bank's descriptor count records
whether it is prepared. Process each completion snapshot as one epoch:
retire all completed channels, submit each prepared peer bank, release
the completed mappings, then refill free banks from a shared cursor. This
keeps both engines fed without assuming a completion order. Keep a rolling
next-IV value and snapshot one IV for each queued task before DMA can
overwrite in-place ciphertext.

The H616 descriptor format uses word addresses. Map each word-aligned
bank independently, stage only its partial cacheline edges in private
aligned buffers, and map the cacheline-aligned middle directly. Build
each task's source and destination lists from those logical segments.
This isolates neighboring cachelines while preparation of the peer bank
overlaps DMA on the active bank, retaining aligned throughput for
cacheline-misaligned payloads. Support exact in-place operation, preserve
dirty bytes outside out-of-place DMA ranges, reject partial overlaps, and
use a fixed 64 KiB repack buffer only for byte addresses the descriptor
format cannot represent. Keep one CE session for the complete request,
including every bounded repack chunk.

Require DMA output mappings to cover complete cachelines so invalidation
cannot discard adjacent dirty data. Retire a channel only after its
completion and that channel's DMA current source and destination
registers are idle. Validate mapped buffers and descriptor chains before
encoding their hardware addresses, and assert the hardware descriptor
layout at build time. Use one cleanup path for normal and forced session
teardown. Track per-channel deadlines independently so activity on one
engine cannot extend another engine's timeout.

Model the H6 and H616 compatibles after the Linux sun8i-ce variant data.
Both variants use byte-sized cipher task lengths and provide the second
RAES engine; H616 additionally needs word-addressed descriptors. Program
the H616 module clock divider for 300 MHz from PLL_PERI0(2X). Select the
required SPL crypto, clock and reset support from SPL_SUNXI_CE, retain the
CE and clock-provider nodes in the pre-RAM device tree, and use the same
bulk clock/reset lifecycle in SPL and U-Boot proper.

Enable device removal in SPL as well as U-Boot proper so a failed child
bind can unbind earlier children before driver-model frees their parent.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Unbind previously bound CE children on a later bind failure and enable
    device removal in both phases so SPL also performs the unwind

Changes v4 -> v5:
  - Make the blocking chain helper close-on-error contract explicit and
    avoid a redundant close in the one-shot wrapper
  - Store the module-clock register value in variant data and share one
    H6/H616 clock-programming path
  - Reorder fixed bank bookkeeping before aligned DMA storage to remove
    avoidable alignment holes
  - Replace channel and engine claims with one exclusive parent session
    tracking in-flight channels, independent deadlines and abort cleanup
  - Move channel, method, tail interrupt and next-pointer setup into shared
    submission, validate descriptor DMA ranges and wait for DMA idle
  - Use the normal bulk clock and reset lifecycle in SPL and U-Boot proper,
    select its SPL dependencies and retain the required pre-RAM DT nodes
  - Replace the separate one-shot, bounce and dual-CBC paths with one
    bounded one/two-lane scheduler, extending dual-engine scheduling to
    word-aligned ECB requests of at least 256 KiB
  - Drive each lane with two fixed banks of ten tasks, use fair refill from
    a shared cursor, and submit prepared peers before CPU cache work
  - Keep one session and rolling CBC IV across the complete operation,
    with one compact IV snapshot for each queued task
  - Direct-map word-aligned cacheline-offset buffers using private head and
    tail cachelines plus SG middles, including exact in-place operation
  - Use a fixed 64 KiB repack for byte-unaligned buffers, reject partial
    overlap and validate length and address overflow
  - Map only the configured key bytes and require output DMA mappings to
    own complete cachelines
  - Assert the hardware descriptor layout and reset active hardware before
    releasing mappings after an error

Changes v3 -> v4:
  - Drop invariant variant fields and redundant chain mapping state
  - Add per-channel task sessions and engine ownership
  - Use AES and RAES in parallel for CBC decrypts of at least 256 KiB
    in SPL and U-Boot proper
  - Double-buffer ten-descriptor chains with tail-only completion
  - Support exact in-place decrypt and aligned-offset input buffers
  - Map scheduler indices directly to AES/RAES channels and engine bits
  - Drop redundant internal bounds checks and session initialization
  - Reuse the scheduled CE register-wait helper and return status
    separately

Changes v2 -> v3:
  - Run the H616 CE module clock at 300 MHz

Changes v1 -> v2:
  - Expose slot 0 as the software-provided AES key slot
---
 MAINTAINERS                                       |   1 +
 arch/arm/dts/sunxi-u-boot.dtsi                    |  15 +
 drivers/crypto/Kconfig                            |   2 +
 drivers/crypto/Makefile                           |   1 +
 drivers/crypto/allwinner/Kconfig                  |   3 +
 drivers/crypto/allwinner/Makefile                 |   3 +
 drivers/crypto/allwinner/sun8i-ce/Kconfig         |  43 ++
 drivers/crypto/allwinner/sun8i-ce/Makefile        |   4 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c  | 809 ++++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 787 +++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h      | 120 ++++
 11 files changed, 1788 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 28d090d3c36..e59fd8721f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -700,6 +700,7 @@ F:	arch/arm/include/asm/arch-sunxi/
 F:	arch/arm/mach-sunxi/
 F:	board/sunxi/
 F:	drivers/clk/sunxi/
+F:	drivers/crypto/allwinner/
 F:	drivers/phy/allwinner/
 F:	drivers/pinctrl/sunxi/
 F:	drivers/video/sunxi/
diff --git a/arch/arm/dts/sunxi-u-boot.dtsi b/arch/arm/dts/sunxi-u-boot.dtsi
index e1a9a7f5d4c..c1dc7404bf8 100644
--- a/arch/arm/dts/sunxi-u-boot.dtsi
+++ b/arch/arm/dts/sunxi-u-boot.dtsi
@@ -19,6 +19,21 @@
 	};
 };
 
+#ifdef CONFIG_SPL_CLK
+&ccu {
+	bootph-pre-ram;
+};
+
+&rtc {
+	bootph-pre-ram;
+};
+#endif
+
+#ifdef CONFIG_SPL_SUNXI_CE
+&crypto {
+	bootph-pre-ram;
+};
+#endif
 /* Let U-Boot be the firmware layer that controls the watchdog. */
 #ifdef CONFIG_MACH_SUN8I_R528
 &wdt {
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 0d58e3910fe..d15a59f87ee 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -6,6 +6,8 @@ source "drivers/crypto/aes/Kconfig"
 
 source "drivers/crypto/fsl/Kconfig"
 
+source "drivers/crypto/allwinner/Kconfig"
+
 source "drivers/crypto/aspeed/Kconfig"
 
 source "drivers/crypto/nuvoton/Kconfig"
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 8170e4cae9c..8cef3adcf05 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -9,6 +9,7 @@ obj-y += aes/
 obj-y += rsa_mod_exp/
 obj-y += fsl/
 obj-y += hash/
+obj-y += allwinner/
 obj-y += aspeed/
 obj-y += nuvoton/
 obj-y += tegra/
diff --git a/drivers/crypto/allwinner/Kconfig b/drivers/crypto/allwinner/Kconfig
new file mode 100644
index 00000000000..9765b089e25
--- /dev/null
+++ b/drivers/crypto/allwinner/Kconfig
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+source "drivers/crypto/allwinner/sun8i-ce/Kconfig"
diff --git a/drivers/crypto/allwinner/Makefile b/drivers/crypto/allwinner/Makefile
new file mode 100644
index 00000000000..2dcae98bac9
--- /dev/null
+++ b/drivers/crypto/allwinner/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y += sun8i-ce/
diff --git a/drivers/crypto/allwinner/sun8i-ce/Kconfig b/drivers/crypto/allwinner/sun8i-ce/Kconfig
new file mode 100644
index 00000000000..ee011cf8280
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/Kconfig
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+config SUNXI_CE
+	bool
+	depends on ARCH_SUNXI
+	depends on CLK && DM_RESET
+	select DM_DEVICE_REMOVE
+
+config SPL_SUNXI_CE
+	bool
+	depends on ARCH_SUNXI
+	depends on MACH_SUN50I_H6 || MACH_SUN50I_H616
+	depends on SPL_DM
+	depends on SPL_OF_CONTROL
+	select SPL_CLK
+	select SPL_CRYPTO
+	select SPL_DM_RESET
+	select SPL_DM_DEVICE_REMOVE
+
+config SUNXI_CE_AES
+	bool "Allwinner sunxi CE AES"
+	depends on ARCH_SUNXI
+	depends on DM_AES
+	depends on CLK && DM_RESET
+	select AES
+	select SUNXI_CE
+	help
+	  Select this option to enable AES encryption and decryption using
+	  the Crypto Engine found in Allwinner sunxi SoCs. The driver
+	  supports software-provided AES-128, AES-192 and AES-256 keys.
+
+config SPL_SUNXI_CE_AES
+	bool "Allwinner sunxi CE AES in SPL"
+	depends on ARCH_SUNXI
+	depends on MACH_SUN50I_H6 || MACH_SUN50I_H616
+	depends on SPL_DM_AES
+	depends on SPL_OF_CONTROL
+	select SPL_CRYPTO
+	select SPL_SUNXI_CE
+	help
+	  Select this option to enable AES decryption in SPL using the Crypto
+	  Engine found in Allwinner H6 and H616 compatible SoCs. This can be
+	  used to decrypt FIT images before loading U-Boot proper.
diff --git a/drivers/crypto/allwinner/sun8i-ce/Makefile b/drivers/crypto/allwinner/sun8i-ce/Makefile
new file mode 100644
index 00000000000..2a8778065b1
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-$(CONFIG_$(PHASE_)SUNXI_CE) += sun8i-ce-core.o
+obj-$(CONFIG_$(PHASE_)SUNXI_CE_AES) += sun8i-ce-aes.o
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c
new file mode 100644
index 00000000000..8dde4863642
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c
@@ -0,0 +1,809 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 James Hilliard
+ */
+
+#define LOG_CATEGORY UCLASS_AES
+
+#include <dm.h>
+#include <limits.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <u-boot/schedule.h>
+#include <uboot_aes.h>
+#include <asm/cache.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include "sun8i-ce.h"
+
+#define SUNXI_CE_ENCRYPTION		0
+#define SUNXI_CE_DECRYPTION		BIT(8)
+
+#define SUNXI_CE_OP_ECB			0
+#define SUNXI_CE_OP_CBC			BIT(8)
+
+#define SUNXI_CE_AES_KEY_128BIT		0
+#define SUNXI_CE_AES_KEY_192BIT		1
+#define SUNXI_CE_AES_KEY_256BIT		2
+
+#define SUNXI_CE_AES_TASK_SIZE		(128 * 1024)
+#define SUNXI_CE_AES_TASK_BLOCKS		\
+	(SUNXI_CE_AES_TASK_SIZE / AES_BLOCK_LENGTH)
+#define SUNXI_CE_AES_CHAIN_DEPTH		10
+#define SUNXI_CE_AES_MAX_LANES		2
+#define SUNXI_CE_AES_BANK_COUNT		2
+#define SUNXI_CE_AES_DUAL_MIN_BLOCKS	\
+	(SUNXI_CE_AES_MAX_LANES * SUNXI_CE_AES_TASK_BLOCKS)
+#define SUNXI_CE_AES_REPACK_SIZE		(64 * 1024)
+#define SUNXI_CE_AES_REPACK_BLOCKS	\
+	(SUNXI_CE_AES_REPACK_SIZE / AES_BLOCK_LENGTH)
+#define SUNXI_CE_AES_NO_BANK		SUNXI_CE_AES_BANK_COUNT
+
+static_assert(SUNXI_CE_AES_BANK_COUNT == 2);
+
+enum sunxi_aes_segment_type {
+	SUNXI_AES_SEGMENT_HEAD,
+	SUNXI_AES_SEGMENT_MIDDLE,
+	SUNXI_AES_SEGMENT_TAIL,
+	SUNXI_AES_SEGMENT_COUNT,
+};
+
+struct sunxi_aes_priv {
+	u8 key[AES256_KEY_LENGTH] __aligned(sizeof(u32));
+	u8 key_len;
+	u8 ce_key_size;
+};
+
+struct sunxi_aes_segment {
+	dma_addr_t dma;
+	u32 len;
+};
+
+struct sunxi_aes_bank_map {
+	u8 src_edges[2][ARCH_DMA_MINALIGN] __aligned(ARCH_DMA_MINALIGN);
+	u8 dst_edges[2][ARCH_DMA_MINALIGN] __aligned(ARCH_DMA_MINALIGN);
+	struct sunxi_ce_dma_buf src_edges_dma;
+	struct sunxi_ce_dma_buf src_middle_dma;
+	struct sunxi_ce_dma_buf dst_edges_dma;
+	struct sunxi_ce_dma_buf dst_middle_dma;
+	struct sunxi_aes_segment src_segments[SUNXI_AES_SEGMENT_COUNT];
+	struct sunxi_aes_segment dst_segments[SUNXI_AES_SEGMENT_COUNT];
+	u32 dst_head;
+	u32 dst_tail;
+};
+
+struct sunxi_aes_bank {
+	struct sunxi_ce_task tasks[SUNXI_CE_AES_CHAIN_DEPTH]
+		__aligned(ARCH_DMA_MINALIGN);
+	size_t offset;
+	u32 len;
+	/* Zero means free; otherwise every DMA mapping remains owned here. */
+	u32 task_count;
+	u8 ivs[SUNXI_CE_AES_CHAIN_DEPTH][AES_BLOCK_LENGTH]
+		__aligned(ARCH_DMA_MINALIGN);
+	struct sunxi_ce_dma_buf iv_dma;
+	struct sunxi_aes_bank_map data;
+};
+
+struct sunxi_aes_lane {
+	struct sunxi_aes_bank banks[SUNXI_CE_AES_BANK_COUNT];
+	/* Submitted bank, or SUNXI_CE_AES_NO_BANK while the lane is idle. */
+	u8 active_bank;
+};
+
+struct sunxi_aes_xfer {
+	struct sunxi_ce_session session;
+	dma_addr_t key_dma;
+	u8 *src;
+	u8 *dst;
+	size_t cursor;
+	u32 remaining;
+	u32 comm_ctl;
+	u32 sym_ctl;
+	u8 lane_count;
+	u8 next_iv[AES_BLOCK_LENGTH];
+	struct sunxi_aes_lane lanes[SUNXI_CE_AES_MAX_LANES];
+};
+
+static const u8 sunxi_aes_methods[SUNXI_CE_AES_MAX_LANES] = {
+	SUNXI_CE_METHOD_AES,
+	SUNXI_CE_METHOD_RAES,
+};
+
+static bool sunxi_aes_is_cbc(const struct sunxi_aes_xfer *xfer)
+{
+	return xfer->sym_ctl & SUNXI_CE_OP_CBC;
+}
+
+static bool sunxi_aes_is_decrypt(const struct sunxi_aes_xfer *xfer)
+{
+	return xfer->comm_ctl & SUNXI_CE_DECRYPTION;
+}
+
+static bool sunxi_aes_is_serial(const struct sunxi_aes_xfer *xfer)
+{
+	return sunxi_aes_is_cbc(xfer) && !sunxi_aes_is_decrypt(xfer);
+}
+
+static u32 sunxi_aes_other_bank(u32 bank_index)
+{
+	return bank_index ^ 1;
+}
+
+static int sunxi_ce_key_size(u32 key_bits)
+{
+	switch (key_bits) {
+	case AES128_KEY_LENGTH * 8:
+		return SUNXI_CE_AES_KEY_128BIT;
+	case AES192_KEY_LENGTH * 8:
+		return SUNXI_CE_AES_KEY_192BIT;
+	case AES256_KEY_LENGTH * 8:
+		return SUNXI_CE_AES_KEY_256BIT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static bool sunxi_aes_ranges_overlap(const u8 *src, const u8 *dst, size_t len)
+{
+	uintptr_t src_start = (uintptr_t)src;
+	uintptr_t dst_start = (uintptr_t)dst;
+
+	if (src_start < dst_start)
+		return dst_start - src_start < len;
+
+	return src_start - dst_start < len;
+}
+
+static u8 sunxi_aes_lane_count(struct sunxi_ce_priv *ce, bool cbc,
+			       bool decrypt, u32 num_blocks)
+{
+	if (ce->variant->aes_engine_count > 1 && (!cbc || decrypt) &&
+	    num_blocks >= SUNXI_CE_AES_DUAL_MIN_BLOCKS)
+		return SUNXI_CE_AES_MAX_LANES;
+
+	return 1;
+}
+
+static void sunxi_aes_edge_lengths(const u8 *buf, u32 len, u32 *head,
+				   u32 *middle, u32 *tail)
+{
+	*head = (ARCH_DMA_MINALIGN -
+		 ((uintptr_t)buf & (ARCH_DMA_MINALIGN - 1))) &
+		(ARCH_DMA_MINALIGN - 1);
+	*head = min(*head, len);
+	*middle = ALIGN_DOWN(len - *head, ARCH_DMA_MINALIGN);
+	*tail = len - *head - *middle;
+}
+
+static void sunxi_aes_release_bank_data(struct sunxi_aes_bank_map *map,
+					u8 *dst, u32 len,
+					bool commit_output)
+{
+	sunxi_ce_dma_unmap(&map->dst_middle_dma);
+	sunxi_ce_dma_unmap(&map->dst_edges_dma);
+	sunxi_ce_dma_unmap(&map->src_middle_dma);
+	sunxi_ce_dma_unmap(&map->src_edges_dma);
+
+	if (commit_output) {
+		if (map->dst_head)
+			memcpy(dst, map->dst_edges[0], map->dst_head);
+		if (map->dst_tail)
+			memcpy(dst + len - map->dst_tail,
+			       map->dst_edges[1], map->dst_tail);
+	}
+
+	memset(map, 0, sizeof(*map));
+}
+
+static int sunxi_aes_map_bank_data(struct sunxi_ce_priv *ce,
+				   struct sunxi_aes_bank_map *map,
+				   u8 *src, u8 *dst, u32 len)
+{
+	u32 src_head, src_middle, src_tail;
+	u32 dst_head, dst_middle, dst_tail;
+	enum dma_data_direction src_dir;
+	bool in_place = src == dst;
+	int ret;
+
+	if (!IS_ALIGNED((uintptr_t)src, sizeof(u32)) ||
+	    !IS_ALIGNED((uintptr_t)dst, sizeof(u32)) ||
+	    !IS_ALIGNED(len, sizeof(u32)))
+		return -EINVAL;
+
+	memset(map, 0, sizeof(*map));
+	src_dir = in_place ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
+
+	/* Independently refilled banks must not share DMA cache envelopes. */
+	sunxi_aes_edge_lengths(src, len, &src_head, &src_middle, &src_tail);
+	sunxi_aes_edge_lengths(dst, len, &dst_head, &dst_middle, &dst_tail);
+	map->dst_head = dst_head;
+	map->dst_tail = dst_tail;
+
+	if (src_head)
+		memcpy(map->src_edges[0], src, src_head);
+	if (src_tail)
+		memcpy(map->src_edges[1], src + len - src_tail, src_tail);
+	if (src_head || src_tail) {
+		ret = sunxi_ce_dma_map(ce, &map->src_edges_dma, map->src_edges,
+				       sizeof(map->src_edges), DMA_TO_DEVICE);
+		if (ret)
+			return ret;
+	}
+
+	if (src_middle) {
+		ret = sunxi_ce_dma_map(ce, &map->src_middle_dma, src + src_head,
+				       src_middle, src_dir);
+		if (ret)
+			return ret;
+	}
+
+	if (dst_head || dst_tail) {
+		ret = sunxi_ce_dma_map(ce, &map->dst_edges_dma, map->dst_edges,
+				       sizeof(map->dst_edges), DMA_FROM_DEVICE);
+		if (ret)
+			return ret;
+	}
+
+	if (!in_place && dst_middle) {
+		ret = sunxi_ce_dma_map(ce, &map->dst_middle_dma, dst + dst_head,
+				       dst_middle, DMA_FROM_DEVICE);
+		if (ret)
+			return ret;
+	}
+
+	map->src_segments[SUNXI_AES_SEGMENT_HEAD].dma = map->src_edges_dma.dma;
+	map->src_segments[SUNXI_AES_SEGMENT_HEAD].len = src_head;
+	map->src_segments[SUNXI_AES_SEGMENT_MIDDLE].dma = map->src_middle_dma.dma;
+	map->src_segments[SUNXI_AES_SEGMENT_MIDDLE].len = src_middle;
+	map->src_segments[SUNXI_AES_SEGMENT_TAIL].dma =
+		map->src_edges_dma.dma + ARCH_DMA_MINALIGN;
+	map->src_segments[SUNXI_AES_SEGMENT_TAIL].len = src_tail;
+
+	map->dst_segments[SUNXI_AES_SEGMENT_HEAD].dma = map->dst_edges_dma.dma;
+	map->dst_segments[SUNXI_AES_SEGMENT_HEAD].len = dst_head;
+	map->dst_segments[SUNXI_AES_SEGMENT_MIDDLE].dma =
+		in_place ? map->src_middle_dma.dma : map->dst_middle_dma.dma;
+	map->dst_segments[SUNXI_AES_SEGMENT_MIDDLE].len = dst_middle;
+	map->dst_segments[SUNXI_AES_SEGMENT_TAIL].dma =
+		map->dst_edges_dma.dma + ARCH_DMA_MINALIGN;
+	map->dst_segments[SUNXI_AES_SEGMENT_TAIL].len = dst_tail;
+
+	return 0;
+}
+
+static int sunxi_aes_fill_sg(struct sunxi_ce_priv *ce,
+			     struct sunxi_ce_sginfo *sg,
+			     const struct sunxi_aes_segment *segments,
+			     u32 offset, u32 len)
+{
+	u32 end = offset + len;
+	u32 covered = 0;
+	u32 segment_offset = 0;
+	u8 i, sg_count = 0;
+
+	for (i = 0; i < SUNXI_AES_SEGMENT_COUNT; i++) {
+		u32 segment_end = segment_offset + segments[i].len;
+		u32 start = max(offset, segment_offset);
+		u32 stop = min(end, segment_end);
+		u32 part_len;
+		dma_addr_t dma;
+
+		if (start >= stop) {
+			segment_offset = segment_end;
+			continue;
+		}
+		if (sg_count >= SUNXI_CE_MAX_SG)
+			return -EINVAL;
+
+		part_len = stop - start;
+		if (!IS_ALIGNED(part_len, sizeof(u32)))
+			return -EINVAL;
+		dma = segments[i].dma + start - segment_offset;
+		sg[sg_count].addr = sunxi_ce_desc_dma_addr(ce, dma);
+		sg[sg_count].len = part_len / sizeof(u32);
+		covered += part_len;
+		sg_count++;
+		segment_offset = segment_end;
+	}
+
+	return covered == len ? 0 : -EINVAL;
+}
+
+static void sunxi_aes_init_task(struct sunxi_ce_priv *ce,
+				struct sunxi_ce_task *task,
+				dma_addr_t key, dma_addr_t iv,
+				u32 len, u32 comm_ctl, u32 sym_ctl)
+{
+	memset(task, 0, sizeof(*task));
+
+	task->t_common_ctl = comm_ctl;
+	task->t_sym_ctl = sym_ctl;
+	task->t_key = sunxi_ce_desc_dma_addr(ce, key);
+	if (iv)
+		task->t_iv = sunxi_ce_desc_dma_addr(ce, iv);
+	task->t_dlen = len;
+}
+
+static u32 sunxi_aes_fair_blocks(struct sunxi_aes_xfer *xfer,
+				 u32 lanes_left)
+{
+	if (!xfer->remaining)
+		return 0;
+
+	return 1 + (xfer->remaining - 1) / lanes_left;
+}
+
+static void sunxi_aes_release_bank(struct sunxi_aes_xfer *xfer,
+				   struct sunxi_aes_bank *bank,
+				   bool commit_output)
+{
+	u8 *dst = xfer->dst + bank->offset;
+	u32 len = bank->len;
+
+	sunxi_aes_release_bank_data(&bank->data, dst, len, commit_output);
+	sunxi_ce_dma_unmap(&bank->iv_dma);
+
+	if (commit_output && sunxi_aes_is_serial(xfer))
+		memcpy(xfer->next_iv, dst + len - AES_BLOCK_LENGTH,
+		       AES_BLOCK_LENGTH);
+
+	bank->offset = 0;
+	bank->len = 0;
+	bank->task_count = 0;
+}
+
+static void sunxi_aes_release_all_banks(struct sunxi_aes_xfer *xfer)
+{
+	u32 bank_index, lane_index;
+
+	for (lane_index = 0; lane_index < xfer->lane_count; lane_index++) {
+		struct sunxi_aes_lane *lane = &xfer->lanes[lane_index];
+
+		for (bank_index = 0; bank_index < SUNXI_CE_AES_BANK_COUNT;
+		     bank_index++)
+			sunxi_aes_release_bank(xfer, &lane->banks[bank_index],
+					       false);
+		lane->active_bank = SUNXI_CE_AES_NO_BANK;
+	}
+}
+
+static int sunxi_aes_prepare_bank(struct sunxi_aes_xfer *xfer, u32 lane_index,
+				  u32 bank_index, u32 max_blocks)
+{
+	struct sunxi_aes_lane *lane = &xfer->lanes[lane_index];
+	struct sunxi_aes_bank *bank = &lane->banks[bank_index];
+	struct sunxi_ce_priv *ce = xfer->session.ce;
+	u32 chain_depth = sunxi_aes_is_serial(xfer) ? 1 :
+			  SUNXI_CE_AES_CHAIN_DEPTH;
+	u32 blocks, offset = 0;
+	u32 task_index;
+	int ret;
+
+	if (!xfer->remaining)
+		return 0;
+	if (lane->active_bank == bank_index || bank->task_count)
+		return -EBUSY;
+
+	blocks = min(xfer->remaining, max_blocks);
+	blocks = min_t(u32, blocks,
+		       chain_depth * SUNXI_CE_AES_TASK_BLOCKS);
+	bank->offset = xfer->cursor;
+	bank->len = blocks * AES_BLOCK_LENGTH;
+	bank->task_count = DIV_ROUND_UP(blocks, SUNXI_CE_AES_TASK_BLOCKS);
+
+	if (sunxi_aes_is_cbc(xfer)) {
+		for (task_index = 0; task_index < bank->task_count; task_index++) {
+			u32 task_len = min_t(u32, bank->len - offset,
+						SUNXI_CE_AES_TASK_SIZE);
+
+			/* Snapshot before an in-place task can overwrite ciphertext. */
+			memcpy(bank->ivs[task_index], xfer->next_iv,
+			       AES_BLOCK_LENGTH);
+			if (sunxi_aes_is_decrypt(xfer))
+				memcpy(xfer->next_iv,
+				       xfer->src + bank->offset + offset + task_len -
+				       AES_BLOCK_LENGTH, AES_BLOCK_LENGTH);
+			offset += task_len;
+		}
+
+		ret = sunxi_ce_dma_map(ce, &bank->iv_dma, bank->ivs,
+				       bank->task_count * AES_BLOCK_LENGTH,
+				       DMA_TO_DEVICE);
+		if (ret)
+			goto out_release;
+	}
+
+	ret = sunxi_aes_map_bank_data(ce, &bank->data,
+				      xfer->src + bank->offset,
+				      xfer->dst + bank->offset, bank->len);
+	if (ret)
+		goto out_release;
+
+	for (task_index = 0, offset = 0; task_index < bank->task_count;
+	     task_index++) {
+		struct sunxi_ce_task *task = &bank->tasks[task_index];
+		u32 task_len = min_t(u32, bank->len - offset,
+						SUNXI_CE_AES_TASK_SIZE);
+		dma_addr_t iv = sunxi_aes_is_cbc(xfer) ? bank->iv_dma.dma +
+					      task_index * AES_BLOCK_LENGTH : 0;
+
+		sunxi_aes_init_task(ce, task, xfer->key_dma, iv,
+				    task_len, xfer->comm_ctl, xfer->sym_ctl);
+		ret = sunxi_aes_fill_sg(ce, task->t_src,
+					bank->data.src_segments,
+					offset, task_len);
+		if (ret)
+			goto out_release;
+		ret = sunxi_aes_fill_sg(ce, task->t_dst,
+					bank->data.dst_segments,
+					offset, task_len);
+		if (ret)
+			goto out_release;
+
+		offset += task_len;
+	}
+	xfer->cursor += bank->len;
+	xfer->remaining -= blocks;
+
+	return 0;
+
+out_release:
+	sunxi_aes_release_bank(xfer, bank, false);
+
+	return ret;
+}
+
+static int sunxi_aes_submit_bank(struct sunxi_aes_xfer *xfer, u32 lane_index,
+				 u32 bank_index)
+{
+	struct sunxi_aes_lane *lane = &xfer->lanes[lane_index];
+	struct sunxi_aes_bank *bank = &lane->banks[bank_index];
+	int ret;
+
+	if (!bank->task_count)
+		return 0;
+	if (lane->active_bank != SUNXI_CE_AES_NO_BANK)
+		return -EINVAL;
+
+	ret = sunxi_ce_session_submit_chain(&xfer->session, lane_index,
+					    sunxi_aes_methods[lane_index],
+					    bank->tasks, bank->task_count);
+	if (!ret)
+		lane->active_bank = bank_index;
+
+	return ret;
+}
+
+static int sunxi_aes_service(struct sunxi_aes_xfer *xfer, u32 completed_mask)
+{
+	u8 completed_banks[SUNXI_CE_AES_MAX_LANES] = {
+		SUNXI_CE_AES_NO_BANK,
+		SUNXI_CE_AES_NO_BANK,
+	};
+	u32 lane_index, refills_left = 0;
+	int ret;
+
+	/* Snapshot completions before changing or releasing any bank state. */
+	for (lane_index = 0; lane_index < xfer->lane_count; lane_index++) {
+		struct sunxi_aes_lane *lane = &xfer->lanes[lane_index];
+
+		if (!(completed_mask & SUNXI_CE_CHAN_MASK(lane_index)))
+			continue;
+		if (lane->active_bank == SUNXI_CE_AES_NO_BANK)
+			return -EINVAL;
+
+		completed_banks[lane_index] = lane->active_bank;
+		lane->active_bank = SUNXI_CE_AES_NO_BANK;
+		refills_left++;
+	}
+
+	/* Submit every prepared peer before doing CPU-side continuation work. */
+	for (lane_index = 0; lane_index < xfer->lane_count; lane_index++) {
+		u32 peer_bank;
+
+		if (completed_banks[lane_index] == SUNXI_CE_AES_NO_BANK)
+			continue;
+		peer_bank = sunxi_aes_other_bank(completed_banks[lane_index]);
+		ret = sunxi_aes_submit_bank(xfer, lane_index, peer_bank);
+		if (ret)
+			return ret;
+	}
+
+	/* Retire completed mappings and commit their edge cache lines. */
+	for (lane_index = 0; lane_index < xfer->lane_count; lane_index++) {
+		struct sunxi_aes_bank *bank;
+
+		if (completed_banks[lane_index] == SUNXI_CE_AES_NO_BANK)
+			continue;
+		bank = &xfer->lanes[lane_index].banks[completed_banks[lane_index]];
+		sunxi_aes_release_bank(xfer, bank, true);
+	}
+
+	/* Refill each newly free bank, then submit it if its lane is idle. */
+	for (lane_index = 0; lane_index < xfer->lane_count; lane_index++) {
+		struct sunxi_aes_lane *lane = &xfer->lanes[lane_index];
+		u32 completed_bank = completed_banks[lane_index];
+
+		if (completed_bank == SUNXI_CE_AES_NO_BANK)
+			continue;
+		if (xfer->remaining) {
+			u32 max_blocks = sunxi_aes_fair_blocks(xfer,
+							 refills_left);
+
+			ret = sunxi_aes_prepare_bank(xfer, lane_index,
+						     completed_bank,
+						     max_blocks);
+			if (ret)
+				return ret;
+		}
+		refills_left--;
+		if (lane->active_bank == SUNXI_CE_AES_NO_BANK) {
+			ret = sunxi_aes_submit_bank(xfer, lane_index,
+						    completed_bank);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int sunxi_aes_run_scheduler(struct sunxi_aes_xfer *xfer, u8 *src,
+				   u8 *dst, u32 num_blocks)
+{
+	u32 bank_index, lane_index;
+	int completed, ret;
+
+	xfer->src = src;
+	xfer->dst = dst;
+	xfer->cursor = 0;
+	xfer->remaining = num_blocks;
+	for (lane_index = 0; lane_index < xfer->lane_count; lane_index++)
+		xfer->lanes[lane_index].active_bank = SUNXI_CE_AES_NO_BANK;
+
+	/*
+	 * Prime bank 0 and submit it, then prepare bank 1 as its peer:
+	 *
+	 *   active_bank --> submitted chain
+	 *   other bank  --> prepared chain, or free when task_count is zero
+	 */
+	for (bank_index = 0;
+	     bank_index < (sunxi_aes_is_serial(xfer) ? 1 :
+			   SUNXI_CE_AES_BANK_COUNT);
+	     bank_index++) {
+		for (lane_index = 0; lane_index < xfer->lane_count; lane_index++) {
+			u32 lanes_left = xfer->lane_count - lane_index;
+			u32 max_blocks;
+
+			if (!xfer->remaining)
+				break;
+			max_blocks = sunxi_aes_fair_blocks(xfer, lanes_left);
+			ret = sunxi_aes_prepare_bank(xfer, lane_index, bank_index,
+						     max_blocks);
+			if (ret)
+				return ret;
+			if (!bank_index) {
+				ret = sunxi_aes_submit_bank(xfer, lane_index,
+							    bank_index);
+				if (ret)
+					return ret;
+			}
+		}
+	}
+
+	while (sunxi_ce_session_busy(&xfer->session)) {
+		completed = sunxi_ce_session_poll(&xfer->session);
+		if (completed < 0)
+			return completed;
+		if (!completed) {
+			schedule();
+			continue;
+		}
+
+		ret = sunxi_aes_service(xfer, completed);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int sunxi_aes_run(struct udevice *dev, u8 *iv, u8 *src, u8 *dst,
+			 u32 num_blocks, u32 aes_mode, bool decrypt)
+{
+	struct sunxi_aes_priv *priv = dev_get_priv(dev);
+	struct sunxi_ce_priv *ce = dev_get_priv(dev_get_parent(dev));
+	struct sunxi_ce_dma_buf key_dma = { };
+	struct sunxi_aes_xfer *xfer;
+	u8 *repack = NULL;
+	u8 lane_count;
+	u32 comm_ctl, sym_ctl;
+	bool cbc = aes_mode == SUNXI_CE_OP_CBC;
+	bool word_addressable;
+	size_t total_len;
+	int ret;
+
+	if (!priv->key_len)
+		return -EINVAL;
+	if (!num_blocks)
+		return 0;
+	if (!src || !dst)
+		return -EINVAL;
+	if (cbc && !iv)
+		return -EINVAL;
+
+	if (num_blocks > SIZE_MAX / AES_BLOCK_LENGTH)
+		return -EOVERFLOW;
+	total_len = (size_t)num_blocks * AES_BLOCK_LENGTH;
+	if (total_len > UINTPTR_MAX - (uintptr_t)src ||
+	    total_len > UINTPTR_MAX - (uintptr_t)dst)
+		return -EOVERFLOW;
+	if (src != dst && sunxi_aes_ranges_overlap(src, dst, total_len))
+		return -EINVAL;
+
+	xfer = malloc_cache_aligned(sizeof(*xfer));
+	if (!xfer)
+		return -ENOMEM;
+	memset(xfer, 0, sizeof(*xfer));
+	if (cbc)
+		memcpy(xfer->next_iv, iv, AES_BLOCK_LENGTH);
+
+	ret = sunxi_ce_dma_map(ce, &key_dma, priv->key, priv->key_len,
+			       DMA_TO_DEVICE);
+	if (ret)
+		goto out_free;
+
+	comm_ctl = decrypt ? SUNXI_CE_DECRYPTION : SUNXI_CE_ENCRYPTION;
+	sym_ctl = priv->ce_key_size | aes_mode;
+	word_addressable = IS_ALIGNED((uintptr_t)src, sizeof(u32)) &&
+			   IS_ALIGNED((uintptr_t)dst, sizeof(u32));
+	lane_count = word_addressable ?
+		sunxi_aes_lane_count(ce, cbc, decrypt, num_blocks) : 1;
+	xfer->key_dma = key_dma.dma;
+	xfer->comm_ctl = comm_ctl;
+	xfer->sym_ctl = sym_ctl;
+	xfer->lane_count = lane_count;
+
+	if (!word_addressable) {
+		repack = memalign(ARCH_DMA_MINALIGN, SUNXI_CE_AES_REPACK_SIZE);
+		if (!repack) {
+			ret = -ENOMEM;
+			goto out_unmap_key;
+		}
+	}
+
+	ret = sunxi_ce_session_begin(ce, GENMASK(lane_count - 1, 0),
+				     &xfer->session);
+	if (ret)
+		goto out_unmap_key;
+
+	if (word_addressable) {
+		ret = sunxi_aes_run_scheduler(xfer, src, dst, num_blocks);
+		goto out_close;
+	}
+
+	while (num_blocks) {
+		u32 blocks = min_t(u32, num_blocks,
+				       SUNXI_CE_AES_REPACK_BLOCKS);
+		u32 len = blocks * AES_BLOCK_LENGTH;
+
+		memcpy(repack, src, len);
+		ret = sunxi_aes_run_scheduler(xfer, repack, repack, blocks);
+		if (ret)
+			goto out_close;
+		memcpy(dst, repack, len);
+
+		num_blocks -= blocks;
+		src += len;
+		dst += len;
+	}
+
+	ret = 0;
+
+out_close:
+	/* Stop every lane before releasing any DMA-owned memory. */
+	ret = sunxi_ce_session_close(&xfer->session, ret);
+	sunxi_aes_release_all_banks(xfer);
+out_unmap_key:
+	sunxi_ce_dma_unmap(&key_dma);
+out_free:
+	free(repack);
+	free(xfer);
+
+	return ret;
+}
+
+static int sunxi_aes_available_key_slots(struct udevice *dev)
+{
+	return 1;
+}
+
+static int sunxi_aes_get_software_key_slot(struct udevice *dev)
+{
+	return 0;
+}
+
+static int sunxi_aes_select_key_slot(struct udevice *dev, u32 key_size,
+				     u8 slot)
+{
+	struct sunxi_aes_priv *priv = dev_get_priv(dev);
+	int ce_key_size;
+
+	if (slot)
+		return -EINVAL;
+
+	ce_key_size = sunxi_ce_key_size(key_size);
+	if (ce_key_size < 0)
+		return ce_key_size;
+
+	priv->key_len = key_size / 8;
+	priv->ce_key_size = ce_key_size;
+
+	return 0;
+}
+
+static int sunxi_aes_set_key_for_key_slot(struct udevice *dev, u32 key_size,
+					  u8 *key, u8 slot)
+{
+	struct sunxi_aes_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (!key)
+		return -EINVAL;
+
+	ret = sunxi_aes_select_key_slot(dev, key_size, slot);
+	if (ret)
+		return ret;
+
+	memcpy(priv->key, key, key_size / 8);
+
+	return 0;
+}
+
+static int sunxi_aes_ecb_encrypt(struct udevice *dev, u8 *src, u8 *dst,
+				 u32 num_blocks)
+{
+	return sunxi_aes_run(dev, NULL, src, dst, num_blocks,
+			     SUNXI_CE_OP_ECB, false);
+}
+
+static int sunxi_aes_ecb_decrypt(struct udevice *dev, u8 *src, u8 *dst,
+				 u32 num_blocks)
+{
+	return sunxi_aes_run(dev, NULL, src, dst, num_blocks,
+			     SUNXI_CE_OP_ECB, true);
+}
+
+static int sunxi_aes_cbc_encrypt(struct udevice *dev, u8 *iv, u8 *src,
+				 u8 *dst, u32 num_blocks)
+{
+	return sunxi_aes_run(dev, iv, src, dst, num_blocks,
+			     SUNXI_CE_OP_CBC, false);
+}
+
+static int sunxi_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src,
+				 u8 *dst, u32 num_blocks)
+{
+	return sunxi_aes_run(dev, iv, src, dst, num_blocks,
+			     SUNXI_CE_OP_CBC, true);
+}
+
+static const struct aes_ops sunxi_aes_ops = {
+	.available_key_slots = sunxi_aes_available_key_slots,
+	.get_software_key_slot = sunxi_aes_get_software_key_slot,
+	.select_key_slot = sunxi_aes_select_key_slot,
+	.set_key_for_key_slot = sunxi_aes_set_key_for_key_slot,
+	.aes_ecb_encrypt = sunxi_aes_ecb_encrypt,
+	.aes_ecb_decrypt = sunxi_aes_ecb_decrypt,
+	.aes_cbc_encrypt = sunxi_aes_cbc_encrypt,
+	.aes_cbc_decrypt = sunxi_aes_cbc_decrypt,
+};
+
+U_BOOT_DRIVER(sun8i_ce_aes) = {
+	.name = "sun8i-ce-aes",
+	.id = UCLASS_AES,
+	.ops = &sunxi_aes_ops,
+	.priv_auto = sizeof(struct sunxi_aes_priv),
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
new file mode 100644
index 00000000000..6c4ccf4c61f
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -0,0 +1,787 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 James Hilliard
+ */
+
+#include <cpu_func.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <errno.h>
+#include <time.h>
+#include <u-boot/schedule.h>
+#include <vsprintf.h>
+#include <asm/arch/cpu.h>
+#include <asm/cache.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/string.h>
+#include "sun8i-ce.h"
+
+#define SUNXI_CE_TDQ			0x00
+#define SUNXI_CE_ICR			0x08
+#define SUNXI_CE_ISR			0x0c
+#define SUNXI_CE_TLR			0x10
+#define SUNXI_CE_ESR			0x18
+#define SUNXI_CE_SCSA			0x24
+#define SUNXI_CE_SCDA			0x28
+#define SUNXI_CE_HCSA			0x34
+#define SUNXI_CE_HCDA			0x38
+#define SUNXI_CE_ACSA			0x44
+#define SUNXI_CE_ACDA			0x48
+#define SUNXI_CE_XCSA			0x54
+#define SUNXI_CE_XCDA			0x58
+
+#define SUNXI_CE_ERR_ALGO_NOTSUP	BIT(0)
+#define SUNXI_CE_ERR_DATALEN		BIT(1)
+#define SUNXI_CE_ERR_KEYSRAM		BIT(2)
+#define SUNXI_CE_ERR_ADDR_INVALID	BIT(5)
+#define SUNXI_CE_ERR_KEYLADDER		BIT(6)
+#define SUNXI_CE_TASK_START		BIT(0)
+#define SUNXI_CE_METHOD_MASK		GENMASK(6, 0)
+#define SUNXI_CE_TLR_METHOD_SHIFT	8
+#define SUNXI_CE_WORD_SHIFT		2
+#define SUNXI_CE_TIMEOUT_US		3000000
+
+#define SUN50I_H6_CCU_CE_CLK		0x680
+#define SUN50I_H6_CCU_CE_CLK_SRC_MASK	BIT(24)
+#define SUN50I_H6_CCU_CE_CLK_N_MASK	GENMASK(9, 8)
+#define SUN50I_H6_CCU_CE_CLK_M_MASK	GENMASK(3, 0)
+#define SUN50I_H6_CCU_CE_CLK_GATE	BIT(31)
+#define SUN50I_H6_CCU_CE_CLK_MASK	(SUN50I_H6_CCU_CE_CLK_GATE | \
+					 SUN50I_H6_CCU_CE_CLK_SRC_MASK | \
+					 SUN50I_H6_CCU_CE_CLK_N_MASK | \
+					 SUN50I_H6_CCU_CE_CLK_M_MASK)
+/* PLL_PERI0(2X) / 4 = 300 MHz */
+#define SUN50I_H616_CCU_CE_CLK_M	3
+
+static int sunxi_ce_reset(struct sunxi_ce_priv *priv);
+
+struct sunxi_ce_channel_route {
+	u16 src_reg;
+	u16 dst_reg;
+};
+
+static const struct sunxi_ce_channel_route
+sunxi_ce_channel_routes[SUNXI_CE_MAX_CHANS] = {
+	[SUNXI_CE_CHANNEL_AES] = {
+		.src_reg = SUNXI_CE_SCSA,
+		.dst_reg = SUNXI_CE_SCDA,
+	},
+	[SUNXI_CE_CHANNEL_RAES] = {
+		.src_reg = SUNXI_CE_XCSA,
+		.dst_reg = SUNXI_CE_XCDA,
+	},
+	[SUNXI_CE_CHANNEL_HASH] = {
+		.src_reg = SUNXI_CE_HCSA,
+		.dst_reg = SUNXI_CE_HCDA,
+	},
+	[SUNXI_CE_CHANNEL_ASYM] = {
+		.src_reg = SUNXI_CE_ACSA,
+		.dst_reg = SUNXI_CE_ACDA,
+	},
+};
+
+u32 sunxi_ce_desc_dma_addr(struct sunxi_ce_priv *priv, dma_addr_t addr)
+{
+	if (priv->variant->needs_word_addresses)
+		addr >>= SUNXI_CE_WORD_SHIFT;
+
+	return (u32)addr;
+}
+
+static void sunxi_ce_flush(void *buf, size_t len)
+{
+	ulong start = ALIGN_DOWN((ulong)buf, ARCH_DMA_MINALIGN);
+	ulong end = ALIGN((ulong)buf + len, ARCH_DMA_MINALIGN);
+
+	flush_dcache_range(start, end);
+}
+
+static int sunxi_ce_validate_dma_range(struct sunxi_ce_priv *priv,
+				       dma_addr_t addr, size_t len)
+{
+	dma_addr_t last;
+
+	if (!IS_ALIGNED(addr, sizeof(u32)))
+		return -EINVAL;
+	if (!len)
+		return 0;
+	if (len - 1 > (dma_addr_t)-1 - addr)
+		return -EOVERFLOW;
+
+	last = addr + len - 1;
+	if (priv->variant->needs_word_addresses)
+		last >>= SUNXI_CE_WORD_SHIFT;
+
+	return last > U32_MAX ? -ERANGE : 0;
+}
+
+int sunxi_ce_dma_map(struct sunxi_ce_priv *priv,
+		     struct sunxi_ce_dma_buf *map, void *buf, size_t len,
+		     enum dma_data_direction dir)
+{
+	ulong addr, map_start, map_end;
+	dma_addr_t base;
+	int ret;
+
+	if (!priv || !map || (!buf && len) || map->map_len)
+		return -EINVAL;
+	if (dir != DMA_TO_DEVICE && dir != DMA_FROM_DEVICE &&
+	    dir != DMA_BIDIRECTIONAL)
+		return -EINVAL;
+	if (!len)
+		return 0;
+	if (dir != DMA_TO_DEVICE &&
+	    (!IS_ALIGNED((ulong)buf, ARCH_DMA_MINALIGN) ||
+	     !IS_ALIGNED(len, ARCH_DMA_MINALIGN)))
+		return -EINVAL;
+
+	addr = (ulong)buf;
+	if (len > ULONG_MAX - addr)
+		return -EOVERFLOW;
+	if (addr + len > ULONG_MAX - (ARCH_DMA_MINALIGN - 1))
+		return -EOVERFLOW;
+	map_start = ALIGN_DOWN(addr, ARCH_DMA_MINALIGN);
+	map_end = ALIGN(addr + len, ARCH_DMA_MINALIGN);
+
+	base = dma_map_single((void *)map_start, map_end - map_start, dir);
+	if (dma_mapping_error(NULL, base))
+		return -EIO;
+
+	map->base = base;
+	map->dma = base + addr - map_start;
+	map->map_len = map_end - map_start;
+	map->dir = dir;
+	ret = sunxi_ce_validate_dma_range(priv, map->dma, len);
+	if (ret) {
+		sunxi_ce_dma_unmap(map);
+		return ret;
+	}
+
+	return 0;
+}
+
+void sunxi_ce_dma_unmap(struct sunxi_ce_dma_buf *map)
+{
+	if (!map || !map->map_len)
+		return;
+
+	dma_unmap_single(map->base, map->map_len, map->dir);
+	memset(map, 0, sizeof(*map));
+}
+
+static void sunxi_ce_print_error(u32 err)
+{
+	printf("CE ERROR: %#x\n", err);
+	if (err & SUNXI_CE_ERR_ALGO_NOTSUP)
+		printf("CE ERROR: algorithm not supported\n");
+	if (err & SUNXI_CE_ERR_DATALEN)
+		printf("CE ERROR: data length error\n");
+	if (err & SUNXI_CE_ERR_KEYSRAM)
+		printf("CE ERROR: keysram access error for AES\n");
+	if (err & SUNXI_CE_ERR_ADDR_INVALID)
+		printf("CE ERROR: address invalid\n");
+	if (err & SUNXI_CE_ERR_KEYLADDER)
+		printf("CE ERROR: key ladder configuration error\n");
+}
+
+static int sunxi_ce_wait(void __iomem *addr, u32 mask, u32 expect)
+{
+	unsigned long timeout = timer_get_us() + SUNXI_CE_TIMEOUT_US;
+	u32 val;
+
+	do {
+		val = readl(addr);
+		if ((val & mask) == expect)
+			return 0;
+		schedule();
+	} while (!time_after(timer_get_us(), timeout));
+
+	val = readl(addr);
+	if ((val & mask) == expect)
+		return 0;
+
+	return -ETIMEDOUT;
+}
+
+static u32 sunxi_ce_error_mask(u32 channel_mask)
+{
+	u32 error_mask = 0;
+	u32 chan;
+
+	for (chan = 0; chan < SUNXI_CE_MAX_CHANS; chan++) {
+		if (channel_mask & SUNXI_CE_CHAN_MASK(chan))
+			error_mask |= SUNXI_CE_CHAN_ERR_MASK(chan);
+	}
+
+	return error_mask;
+}
+
+static int sunxi_ce_prepare_channels(struct sunxi_ce_priv *priv,
+				     u32 channel_mask)
+{
+	u32 error_mask, val;
+	int ret;
+
+	error_mask = sunxi_ce_error_mask(channel_mask);
+
+	val = readl(priv->base + SUNXI_CE_ICR);
+	writel(val | channel_mask, priv->base + SUNXI_CE_ICR);
+	writel(channel_mask, priv->base + SUNXI_CE_ISR);
+	writel(error_mask, priv->base + SUNXI_CE_ESR);
+	ret = sunxi_ce_wait(priv->base + SUNXI_CE_ISR, channel_mask, 0);
+	if (ret) {
+		printf("%s: timeout waiting for stale interrupt\n", __func__);
+		clrbits_le32(priv->base + SUNXI_CE_ICR, channel_mask);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int sunxi_ce_submit_task(struct sunxi_ce_priv *priv,
+				dma_addr_t task_dma, u32 method)
+{
+	u32 load = (method << SUNXI_CE_TLR_METHOD_SHIFT) |
+		   SUNXI_CE_TASK_START;
+	int ret;
+
+	ret = sunxi_ce_wait(priv->base + SUNXI_CE_TLR,
+			    SUNXI_CE_TASK_START, 0);
+	if (ret) {
+		printf("%s: timeout waiting for task launcher\n", __func__);
+		return ret;
+	}
+
+	writel(sunxi_ce_desc_dma_addr(priv, task_dma),
+	       priv->base + SUNXI_CE_TDQ);
+	/* Be sure all data is written before enabling the task. */
+	wmb();
+	writel(load, priv->base + SUNXI_CE_TLR);
+	ret = sunxi_ce_wait(priv->base + SUNXI_CE_TLR,
+			    SUNXI_CE_TASK_START, 0);
+	if (ret)
+		printf("%s: timeout registering task\n", __func__);
+
+	return ret;
+}
+
+static int sunxi_ce_ack_channel(struct sunxi_ce_priv *priv, u32 chan)
+{
+	u32 channel_mask, error_mask, err;
+
+	channel_mask = SUNXI_CE_CHAN_MASK(chan);
+	writel(channel_mask, priv->base + SUNXI_CE_ISR);
+	error_mask = SUNXI_CE_CHAN_ERR_MASK(chan);
+	err = readl(priv->base + SUNXI_CE_ESR) & error_mask;
+	writel(error_mask, priv->base + SUNXI_CE_ESR);
+	if (err) {
+		sunxi_ce_print_error(err >> (chan * 8));
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int sunxi_ce_wait_channel_idle(struct sunxi_ce_priv *priv, u32 chan)
+{
+	const struct sunxi_ce_channel_route *route;
+	int ret;
+
+	if (chan >= SUNXI_CE_MAX_CHANS)
+		return -EINVAL;
+	route = &sunxi_ce_channel_routes[chan];
+
+	ret = sunxi_ce_wait(priv->base + route->src_reg, ~0U, 0);
+	if (!ret)
+		ret = sunxi_ce_wait(priv->base + route->dst_reg, ~0U, 0);
+	if (ret)
+		printf("%s: timeout waiting for channel %u DMA idle\n",
+		       __func__, chan);
+
+	return ret;
+}
+
+static int sunxi_ce_wait_channels_idle(struct sunxi_ce_priv *priv,
+				       u32 channel_mask)
+{
+	u32 chan;
+	int cleanup_ret, ret = 0;
+
+	for (chan = 0; chan < SUNXI_CE_MAX_CHANS; chan++) {
+		if (!(channel_mask & SUNXI_CE_CHAN_MASK(chan)))
+			continue;
+
+		cleanup_ret = sunxi_ce_wait_channel_idle(priv, chan);
+		if (cleanup_ret && !ret)
+			ret = cleanup_ret;
+	}
+
+	return ret;
+}
+
+static int sunxi_ce_clear_errors(struct sunxi_ce_priv *priv, u32 channel_mask)
+{
+	u32 error_mask, err;
+
+	error_mask = sunxi_ce_error_mask(channel_mask);
+	err = readl(priv->base + SUNXI_CE_ESR) & error_mask;
+	writel(error_mask, priv->base + SUNXI_CE_ESR);
+
+	if (err) {
+		u32 chan;
+
+		for (chan = 0; chan < SUNXI_CE_MAX_CHANS; chan++) {
+			u32 chan_err = (err >> (chan * 8)) & 0xff;
+
+			if (chan_err)
+				sunxi_ce_print_error(chan_err);
+		}
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int sunxi_ce_session_check(struct sunxi_ce_session *session)
+{
+	if (!session || !session->ce)
+		return -EINVAL;
+	if (session->ce->active_session != session)
+		return -ECANCELED;
+
+	return 0;
+}
+
+int sunxi_ce_session_begin(struct sunxi_ce_priv *priv, u32 channel_mask,
+			   struct sunxi_ce_session *session)
+{
+	u32 valid_channels = GENMASK(SUNXI_CE_MAX_CHANS - 1, 0);
+	int ret;
+
+	if (!priv || !session || !channel_mask ||
+	    channel_mask & ~valid_channels)
+		return -EINVAL;
+	if (priv->active_session)
+		return -EBUSY;
+
+	memset(session, 0, sizeof(*session));
+	session->ce = priv;
+	session->channel_mask = channel_mask;
+	priv->active_session = session;
+
+	ret = sunxi_ce_prepare_channels(priv, channel_mask);
+	if (ret) {
+		priv->active_session = NULL;
+		session->ce = NULL;
+	}
+
+	return ret;
+}
+
+int sunxi_ce_session_submit_chain(struct sunxi_ce_session *session,
+				  u32 channel, u32 method,
+				  struct sunxi_ce_task *tasks, u32 task_count)
+{
+	dma_addr_t tasks_dma;
+	size_t tasks_len;
+	u32 channel_mask;
+	u32 i;
+	int ret;
+
+	ret = sunxi_ce_session_check(session);
+	if (ret)
+		return ret;
+	if (channel >= SUNXI_CE_MAX_CHANS || method & ~SUNXI_CE_METHOD_MASK)
+		return -EINVAL;
+	channel_mask = SUNXI_CE_CHAN_MASK(channel);
+	if (!(session->channel_mask & channel_mask))
+		return -EINVAL;
+	if (session->inflight_mask & channel_mask)
+		return -EBUSY;
+	if (!tasks || !task_count)
+		return -EINVAL;
+	if (task_count > SIZE_MAX / sizeof(*tasks))
+		return -EOVERFLOW;
+	tasks_len = task_count * sizeof(*tasks);
+	tasks_dma = virt_to_phys(tasks);
+	ret = sunxi_ce_validate_dma_range(session->ce, tasks_dma, tasks_len);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < task_count; i++) {
+		tasks[i].t_id = channel;
+		tasks[i].t_common_ctl &= ~(SUNXI_CE_METHOD_MASK |
+						SUNXI_CE_COMM_INT);
+		tasks[i].t_common_ctl |= method;
+		if (i + 1 == task_count)
+			tasks[i].t_common_ctl |= SUNXI_CE_COMM_INT;
+		tasks[i].next = i + 1 < task_count ?
+			sunxi_ce_desc_dma_addr(session->ce,
+					       tasks_dma +
+					       (i + 1) * sizeof(*tasks)) : 0;
+	}
+
+	sunxi_ce_flush(tasks, tasks_len);
+
+	ret = sunxi_ce_submit_task(session->ce, tasks_dma, method);
+	if (!ret) {
+		session->inflight_mask |= channel_mask;
+		session->deadline[channel] = timer_get_us() + SUNXI_CE_TIMEOUT_US;
+	}
+
+	return ret;
+}
+
+int sunxi_ce_session_poll(struct sunxi_ce_session *session)
+{
+	unsigned long now;
+	u32 channel_mask, completed, pending;
+	unsigned int chan;
+	int ret;
+
+	ret = sunxi_ce_session_check(session);
+	if (ret)
+		return ret;
+
+	completed = readl(session->ce->base + SUNXI_CE_ISR) &
+		    session->inflight_mask;
+	pending = completed;
+	while (pending) {
+		chan = __ffs(pending);
+		channel_mask = SUNXI_CE_CHAN_MASK(chan);
+		pending &= ~channel_mask;
+
+		ret = sunxi_ce_ack_channel(session->ce, chan);
+		if (ret)
+			return ret;
+		ret = sunxi_ce_wait_channel_idle(session->ce, chan);
+		if (ret)
+			return ret;
+		session->inflight_mask &= ~channel_mask;
+		session->deadline[chan] = 0;
+	}
+
+	if (completed) {
+		/* A chain-tail completion orders every preceding output DMA. */
+		rmb();
+	}
+
+	now = timer_get_us();
+	pending = session->inflight_mask;
+	while (pending) {
+		chan = __ffs(pending);
+		channel_mask = SUNXI_CE_CHAN_MASK(chan);
+		pending &= ~channel_mask;
+		if (!time_after(now, session->deadline[chan]))
+			continue;
+
+		/* Do not report a timeout for a completion racing this snapshot. */
+		if (readl(session->ce->base + SUNXI_CE_ISR) & channel_mask)
+			continue;
+
+		printf("%s: DMA timeout on channel %u\n", __func__, chan);
+		return -ETIMEDOUT;
+	}
+
+	return completed;
+}
+
+static int sunxi_ce_session_wait(struct sunxi_ce_session *session)
+{
+	int completed, ret;
+
+	ret = sunxi_ce_session_check(session);
+	if (ret)
+		return ret;
+
+	while (session->inflight_mask) {
+		completed = sunxi_ce_session_poll(session);
+		if (completed < 0)
+			return completed;
+		if (!completed)
+			schedule();
+	}
+
+	return 0;
+}
+
+int sunxi_ce_session_run_chain_or_close(struct sunxi_ce_session *session,
+					u32 channel, u32 method,
+					struct sunxi_ce_task *tasks,
+					u32 task_count)
+{
+	int ret;
+
+	ret = sunxi_ce_session_submit_chain(session, channel, method, tasks,
+					    task_count);
+	if (!ret)
+		ret = sunxi_ce_session_wait(session);
+	if (ret)
+		return sunxi_ce_session_close(session, ret);
+
+	return 0;
+}
+
+static void sunxi_ce_session_release(struct sunxi_ce_session *session)
+{
+	struct sunxi_ce_priv *priv = session->ce;
+
+	priv->active_session = NULL;
+	memset(session, 0, sizeof(*session));
+}
+
+static int sunxi_ce_session_finish(struct sunxi_ce_session *session, bool abort)
+{
+	struct sunxi_ce_priv *priv;
+	u32 channel_mask, valid_channels;
+	int cleanup_ret, idle_ret, ret;
+
+	ret = sunxi_ce_session_check(session);
+	if (ret)
+		return ret;
+
+	priv = session->ce;
+	channel_mask = session->channel_mask;
+	valid_channels = GENMASK(SUNXI_CE_MAX_CHANS - 1, 0);
+	ret = 0;
+
+	if (!abort && session->inflight_mask) {
+		ret = -EBUSY;
+		abort = true;
+	}
+
+	if (!abort) {
+		clrbits_le32(priv->base + SUNXI_CE_ICR, channel_mask);
+		writel(channel_mask, priv->base + SUNXI_CE_ISR);
+		ret = sunxi_ce_clear_errors(priv, channel_mask);
+
+		writel(0, priv->base + SUNXI_CE_TLR);
+		writel(0, priv->base + SUNXI_CE_TDQ);
+		cleanup_ret = sunxi_ce_wait(priv->base + SUNXI_CE_TLR,
+					    SUNXI_CE_TASK_START, 0);
+		readl(priv->base + SUNXI_CE_TDQ);
+		if (cleanup_ret) {
+			printf("%s: timeout clearing task launcher\n", __func__);
+			if (!ret)
+				ret = cleanup_ret;
+			abort = true;
+		}
+	}
+
+	if (abort) {
+		cleanup_ret = sunxi_ce_reset(priv);
+		if (cleanup_ret) {
+			idle_ret = sunxi_ce_wait_channels_idle(priv, channel_mask);
+			if (idle_ret)
+				panic_str("CE: failed to stop DMA");
+			if (!ret)
+				ret = cleanup_ret;
+		}
+
+		/* Reset or observed idle DMA makes releasing mapped memory safe. */
+		rmb();
+		clrbits_le32(priv->base + SUNXI_CE_ICR, valid_channels);
+		writel(valid_channels, priv->base + SUNXI_CE_ISR);
+		writel(sunxi_ce_error_mask(valid_channels),
+		       priv->base + SUNXI_CE_ESR);
+		writel(0, priv->base + SUNXI_CE_TLR);
+		writel(0, priv->base + SUNXI_CE_TDQ);
+	}
+
+	sunxi_ce_session_release(session);
+
+	return ret;
+}
+
+int sunxi_ce_session_close(struct sunxi_ce_session *session, int status)
+{
+	int cleanup_ret;
+
+	if (!session || !session->ce)
+		return status ? status : -EINVAL;
+
+	cleanup_ret = sunxi_ce_session_finish(session, status != 0);
+
+	return status ? status : cleanup_ret;
+}
+
+int sunxi_ce_run_task(struct sunxi_ce_priv *priv, u32 channel, u32 method,
+		      struct sunxi_ce_task *task)
+{
+	struct sunxi_ce_session session;
+	u32 channel_mask;
+	int ret;
+
+	if (channel >= SUNXI_CE_MAX_CHANS)
+		return -EINVAL;
+	channel_mask = SUNXI_CE_CHAN_MASK(channel);
+
+	ret = sunxi_ce_session_begin(priv, channel_mask, &session);
+	if (ret)
+		return ret;
+
+	ret = sunxi_ce_session_run_chain_or_close(&session, channel, method,
+						  task, 1);
+	if (ret)
+		return ret;
+
+	return sunxi_ce_session_close(&session, 0);
+}
+
+static int sunxi_ce_reset(struct sunxi_ce_priv *priv)
+{
+	int ret;
+
+	ret = reset_assert_bulk(&priv->resets);
+	if (ret)
+		return ret;
+
+	udelay(1);
+
+	ret = reset_deassert_bulk(&priv->resets);
+	if (ret)
+		return ret;
+
+	udelay(10);
+
+	return 0;
+}
+
+static void sunxi_ce_setup_mod_clock(const struct sunxi_ce_variant *variant)
+{
+	void __iomem *ccu = (void __iomem *)SUNXI_CCM_BASE;
+
+	clrsetbits_le32(ccu + SUN50I_H6_CCU_CE_CLK,
+			SUN50I_H6_CCU_CE_CLK_MASK, variant->mod_clk_cfg);
+}
+
+static int sunxi_ce_bind_child(struct udevice *dev, const char *name)
+{
+	int ret;
+
+	ret = device_bind_driver(dev, name, name, NULL);
+	/* The bind caller will free the parent on failure. */
+	if (ret)
+		device_chld_unbind(dev, NULL);
+
+	return ret;
+}
+
+static int sunxi_ce_bind(struct udevice *dev)
+{
+	int ret;
+
+	if (CONFIG_IS_ENABLED(SUNXI_CE_AES)) {
+		ret = sunxi_ce_bind_child(dev, "sun8i-ce-aes");
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int sunxi_ce_probe(struct udevice *dev)
+{
+	struct sunxi_ce_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	priv->variant = (const struct sunxi_ce_variant *)
+			dev_get_driver_data(dev);
+	priv->base = dev_read_addr_ptr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	ret = reset_get_bulk(dev, &priv->resets);
+	if (ret) {
+		dev_err(dev, "failed to get resets: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_get_bulk(dev, &priv->clks);
+	if (ret) {
+		dev_err(dev, "failed to get clocks: %d\n", ret);
+		goto err_release_resets;
+	}
+
+	sunxi_ce_setup_mod_clock(priv->variant);
+
+	ret = reset_deassert_bulk(&priv->resets);
+	if (ret) {
+		dev_err(dev, "failed to deassert resets: %d\n", ret);
+		goto err_release_clks;
+	}
+
+	ret = clk_enable_bulk(&priv->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		goto err_assert_resets;
+	}
+
+	ret = sunxi_ce_reset(priv);
+	if (ret) {
+		dev_err(dev, "failed to reset CE: %d\n", ret);
+		goto err_disable_clks;
+	}
+
+	return 0;
+
+err_disable_clks:
+	clk_disable_bulk(&priv->clks);
+err_assert_resets:
+	reset_assert_bulk(&priv->resets);
+err_release_clks:
+	clk_release_bulk(&priv->clks);
+err_release_resets:
+	reset_release_bulk(&priv->resets);
+
+	return ret;
+}
+
+static int sunxi_ce_remove(struct udevice *dev)
+{
+	struct sunxi_ce_priv *priv = dev_get_priv(dev);
+
+	clk_disable_bulk(&priv->clks);
+	clk_release_bulk(&priv->clks);
+	reset_assert_bulk(&priv->resets);
+	reset_release_bulk(&priv->resets);
+
+	return 0;
+}
+
+static const struct sunxi_ce_variant sun50i_h6_variant = {
+	.aes_engine_count = 2,
+};
+
+static const struct sunxi_ce_variant sun50i_h616_variant = {
+	.needs_word_addresses = true,
+	.aes_engine_count = 2,
+	.mod_clk_cfg = SUN50I_H6_CCU_CE_CLK_SRC_MASK |
+		       SUN50I_H616_CCU_CE_CLK_M,
+};
+
+static const struct udevice_id sunxi_ce_ids[] = {
+	{
+		.compatible = "allwinner,sun50i-h6-crypto",
+		.data = (ulong)&sun50i_h6_variant,
+	}, {
+		.compatible = "allwinner,sun50i-h616-crypto",
+		.data = (ulong)&sun50i_h616_variant,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(sun8i_ce) = {
+	.name = "sun8i-ce",
+	.id = UCLASS_NOP,
+	.of_match = sunxi_ce_ids,
+	.bind = sunxi_ce_bind,
+	.probe = sunxi_ce_probe,
+	.remove = sunxi_ce_remove,
+	.priv_auto = sizeof(struct sunxi_ce_priv),
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
new file mode 100644
index 00000000000..d0035af559a
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 James Hilliard
+ */
+
+#ifndef __SUN8I_CE_H
+#define __SUN8I_CE_H
+
+#include <stddef.h>
+#include <clk.h>
+#include <reset.h>
+#include <linux/bitops.h>
+#include <linux/dma-direction.h>
+#include <linux/types.h>
+
+#define SUNXI_CE_CHANNEL_AES		0
+#define SUNXI_CE_CHANNEL_RAES		1
+#define SUNXI_CE_CHANNEL_HASH		2
+#define SUNXI_CE_CHANNEL_ASYM		3
+#define SUNXI_CE_CHAN_MASK(x)		BIT(x)
+#define SUNXI_CE_COMM_INT		BIT(31)
+#define SUNXI_CE_METHOD_AES		0
+#define SUNXI_CE_METHOD_RAES		0x30
+#define SUNXI_CE_MAX_SG			8
+#define SUNXI_CE_MAX_CHANS		4
+#define SUNXI_CE_CHAN_ERR_MASK(x)	(0xffU << ((x) * 8))
+
+struct sunxi_ce_sginfo {
+	u32 addr;
+	u32 len;
+};
+
+struct sunxi_ce_task {
+	u32 t_id;
+	u32 t_common_ctl;
+	u32 t_sym_ctl;
+	u32 t_asym_ctl;
+	u32 t_key;
+	u32 t_iv;
+	u32 t_ctr;
+	u32 t_dlen;
+	struct sunxi_ce_sginfo t_src[SUNXI_CE_MAX_SG];
+	struct sunxi_ce_sginfo t_dst[SUNXI_CE_MAX_SG];
+	u32 next;
+	u32 reserved[3];
+};
+
+static_assert(sizeof(struct sunxi_ce_sginfo) == 8);
+static_assert(offsetof(struct sunxi_ce_task, next) == 160);
+static_assert(sizeof(struct sunxi_ce_task) == 176);
+
+struct sunxi_ce_variant {
+	bool needs_word_addresses;
+	u8 aes_engine_count;
+	u32 mod_clk_cfg;
+};
+
+struct sunxi_ce_session;
+
+struct sunxi_ce_priv {
+	void __iomem *base;
+	const struct sunxi_ce_variant *variant;
+	struct clk_bulk clks;
+	struct reset_ctl_bulk resets;
+	struct sunxi_ce_session *active_session;
+};
+
+struct sunxi_ce_session {
+	struct sunxi_ce_priv *ce;
+	u32 channel_mask;
+	u32 inflight_mask;
+	unsigned long deadline[SUNXI_CE_MAX_CHANS];
+};
+
+static inline bool sunxi_ce_session_busy(const struct sunxi_ce_session *session)
+{
+	return session && session->inflight_mask;
+}
+
+/*
+ * DMA_FROM_DEVICE and DMA_BIDIRECTIONAL buffers must cover complete cache
+ * lines. DMA_TO_DEVICE buffers may use a rounded cache envelope. Keep every
+ * mapping alive until its chain completes or the owning session is closed.
+ */
+struct sunxi_ce_dma_buf {
+	dma_addr_t base;
+	dma_addr_t dma;
+	size_t map_len;
+	enum dma_data_direction dir;
+};
+
+u32 sunxi_ce_desc_dma_addr(struct sunxi_ce_priv *priv, dma_addr_t addr);
+int sunxi_ce_dma_map(struct sunxi_ce_priv *priv,
+		     struct sunxi_ce_dma_buf *map, void *buf, size_t len,
+		     enum dma_data_direction dir);
+void sunxi_ce_dma_unmap(struct sunxi_ce_dma_buf *map);
+/*
+ * A session owns at most one descriptor chain per selected channel. Submission
+ * supplies the descriptor transport fields, including the tail interrupt.
+ * Polling returns a completed-channel mask (or a negative error) after output
+ * DMA is idle and ordered. A nonzero close status aborts all active channels
+ * before callers release their DMA mappings. A blocking run also closes the
+ * session on error so its caller can immediately unwind local DMA mappings.
+ */
+int sunxi_ce_session_begin(struct sunxi_ce_priv *priv, u32 channel_mask,
+			   struct sunxi_ce_session *session);
+int sunxi_ce_session_submit_chain(struct sunxi_ce_session *session,
+				  u32 channel, u32 method,
+				  struct sunxi_ce_task *tasks,
+				  u32 task_count);
+int sunxi_ce_session_poll(struct sunxi_ce_session *session);
+int sunxi_ce_session_run_chain_or_close(struct sunxi_ce_session *session,
+					u32 channel, u32 method,
+					struct sunxi_ce_task *tasks,
+					u32 task_count);
+int sunxi_ce_session_close(struct sunxi_ce_session *session, int status);
+int sunxi_ce_run_task(struct sunxi_ce_priv *priv, u32 channel, u32 method,
+		      struct sunxi_ce_task *task);
+
+#endif

-- 
2.53.0

