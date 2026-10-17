Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EA9CCA463
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 04:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D65381539;
	Sat, 17 Oct 2026 04:36:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1aZpSE_HIGms; Sat, 17 Oct 2026 04:36:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D54418149A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792211794;
	b=EjAyYH/ZjMJevmCyldeHhtCHVtW6NzpgPAJiMkdIk553rgyD6c3JiBYdA9851c+eW59T
	 oyJUY4zwlsgbSnnfxLt+fq7/7UVWzsSL/esyzqbRq0Wt06vxwFMDn7Up0WKcXB/Az4C9Z
	 /7bobmptf8gTew/hf8UEYv9osAjF2E9qp3SRXLaNIZw5paMDTXsRk1mcB0HeuzDbvPSMh
	 k3NAd/+SLUa4EVlhTY+js3E5iOzaUHmUn3THg5PNHgXaIoYqugIeky8hx7Qg7VvGWf/9c
	 +QTFXuW0Jx4x3wncPsNZUZuMrfVBnpyouRjwc4vBAEiTOraMyyaOeRH6g5PQO7OsEIA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792211794;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OKv6lc+cH5ESt7sMwR40WdZti1G/3FqFBrqbz7YaLk0=;
	b=W4WG6xNm6JDEfNRptM1fiVjyFzWEXvVZzTJGiHdLu8mLppjWBNyAgn9zJOYU+RbgutAk
	 r283vx4D8gVJ0SRrxZ8WLnnCNeNxb66YtX9qQ7ljg4BMSWlsgFzQz8MUsJxEwKhj+ccjs
	 YmvlIFhdRCtw+BK2+PrbBLluAl80JUSmB+mGDtkWg4vlfYWMfhqeQ4oItHEgK5J6YyZST
	 TtmljZkWjbUpeXDQ2tuj+mOdaOS33U22woxhMhJ5D2bMnFw/vSZSkCAzQfWAX80ysGerq
	 FzK8bS8rZvlINQ5PHkJ7RjELOXFFWr1O3xN+rDhuv/3rePQN5JwylpGeWxRKw0wc79Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792211794;
	bh=OKv6lc+cH5ESt7sMwR40WdZti1G/3FqFBrqbz7YaLk0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D7qXVoCiqvIxxj0bme7zTDl8RT5VnsTTHKk0juOSYnQOssnbHRuiIGcXohikAtLXD
	 ybEOqV1XhLVbfUxG2ksiBwQFvLZeNR0Xv9cJyx/iDoQNUV0I5lq9auAJiSNhgDcLkp
	 jf8z9OZGuLsNgBkUdUTB6Qfz9iqol/1gBjbNp8juznn9+EdWDEs2imbSCnMkXMDNuu
	 Hdvvmf2hVuhUQLfjyR1Y74XrZoeLYbLzDMIQORk/hK3F5AzyF5ac2dhcW5JTlPXOIa
	 LCvsx1wzJw0rCeX1iB7VWRpzRd9iTb5AqppxXFmCzhHyStevRwlQp6Kbht2+TF2cHT
	 QIlcKi5Sl2Qew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D54418149A;
	Sat, 17 Oct 2026 04:36:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 14477105
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 04592408BD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Wkh1HC54KkQ for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 00:35:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DD4D44022A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792197350;
 b=sZx3vR2kJZoxTkTznH7hFLkjoIJR89i6iTCyy08m8dEb3aeyChw8zMCybGz578UInYBG
 UcreJZE4jedp3r+SjZB6v2IQ66mPGEluKCzyAfyZmxgpim9lAaJe2kyXMxTkYianGa7Ad
 Z5Y9btGUXdiVkfAC3Bz3Sz2CACKF/EDi77GPlq0jmmawl+CylKDZ4BEy3zU7I+zaVAzHg
 mqlzhA8RTGVvoJJnI1V76lexr5KLmEHPbEv7R/nA0QF4hNlM6Khk7z9uLd1vPF0QCpxdQ
 lUs6avghjxKtr2G+PimKsgBhvdoIRyq+LJqt9ISboRdFlJVnE58v6M8ir2j86xSvH6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792197350;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=OKv6lc+cH5ESt7sMwR40WdZti1G/3FqFBrqbz7YaLk0=;
 b=qzgbmajtYB+9CHfwA+wSd7H5J057RhRjmBXjNHVmdGV8/vuqmjKvS3H4MVrgVGuXQpQe
 84RmeFFB2wCCCHr9oP6IFUalwpP5cOeFpPAUQ9TI/C3O/yy5Q2p5o4fb04K7nqJ2L7fU4
 ptu2krfoJjPESdawed8L/I5k0nEjSnXW0RnUU8O9qKGLYPXOEwqwqS5lSjzDh6joQWk9O
 8D9MKHGTefthZU4ie3N14cG6cP2/ePf9IKWqUD3HWexQ/jIfWuz2bvbrGoqZZcTBPVtvP
 YIy7sd+ZwVt5uS+bgcCGvBSGlSQAewpgauxCN7wnrRJLajv14nQPMyjhIgMq7XAHvkA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qKevzIR0; 
 arc=none smtp.remote-ip="2001:4860:4864:20::29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::29; helo=mail-oa1-x29.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qKevzIR0
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD4D44022A
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:48 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-48e94879f02so219563fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792197347; x=1792802147;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OKv6lc+cH5ESt7sMwR40WdZti1G/3FqFBrqbz7YaLk0=;
 b=qKevzIR0MWb/ZeiOneKsO7zENDhvUmOZXGdzW4ZGSownJsByIPzVzawwYERGTMh4LW
 6q4T5GYJgqALWAPjiFyAPVKb8L9nF2iUSrLnYqdnGq9kPwQvovvg93RZmYKW1f8ni45D
 hRuZz/ixMGJ0+8RNaz6LqCFmRjC6ycHBjpqYqKV1VyWHIaLMfxRp+aj1hEsiTOtmvc/s
 YzAW9oo6sCWBdP4sqGXk+KZDIQfbWww/TRA7/Q8hYTRDIQRAniAUCvZTycf0Z2vViZY6
 eK3Lao6p4fC0PZ79RBIPvcB2Q0tO5fFtQfhVGES4MGuZ54JmEX03vkN1SOCI+/iOqOmE
 E/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792197347; x=1792802147;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OKv6lc+cH5ESt7sMwR40WdZti1G/3FqFBrqbz7YaLk0=;
 b=mbQhmgbPSI8cRtegrYbk3WpEkPqeGNBaxqi5FldfU6Lu7CcCjH+kUAWjkdV95kmg8n
 yfJk1o2118E8wlQE30RbAm+i8AX0KPc18BclJbvSVdMGHwSc/hH1BZuO2DiwJNsscfUO
 oQj+JKMNpJMyhOVmj+wsaDwilbVX/T5fqqNRQ3l8IPLLSoIGwIBXshDa424/aV0x6Mlv
 2qxFjF/RYxK+2yy9p53JUxPbvEmSoUVbPnmF9eBooYZnFr87Dzyughdjxq93uKflsg6E
 LiXnNSnHkpzdXXA+tX+nj/xShKDpGf0mbILbMQEfzVQ1fRsOr/LBXLCEqJ+JvGW9hVOj
 qv6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsSCfULYlxGv1QbTbQKgTscGjsRnqPauzo3stHh/eHzVoKD1TTNVBXwawwll4lw27rfRq8uyQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIG+DsVC7p8dt2XF7gRCajSomyWN1SEwGmtPHrHElzUl3i3Muq7
 iSm68RftQ4dqfCI40bq8QEEV/yTCpvqOtawy8qEDJcubu1gTyg8x0AF1
X-Gm-Gg: AYBFou2YbjNz1ejOQq65QWJgxkzD14YDCij5l9RthHGIwIaI0uypVzk8dXpATl7Zbvq
 ABTIoiCuZK8tCRYbFR198rarruAOg0YNRiATV9T/ohoTO4g06fd2pPHvhyqJgictr/oR4yzA2sK
 eD7P2+gze9ysH+aIuRXi6Del3Oxe2N3N2aNkFvcuusP9oK5+dd5exEB8yjs5WuvEtAWKbKaSskh
 gizlynoYgPwwyKw1EYiFiCClS0WziCCALQeBB77ny8PwqjeDFAGMBj4P7cx4UlCdgGFdg9k46IO
 vBYGGtfYT9u4dBE+CAK0pV/ORcGtLA9SOiVO+QBYp8cSDZSvpMFyqe3zFb4f8o+PKGBxVuVoExQ
 N/HfAh0tzll6iZg3rhDy8SSrwlCz1+8qFmJs2DADf68mh35kHbMoleaEsmN6yzF5BjWLZI9fjqB
 xDE0oEp+IcwoU22IY4tE5svYCVAonatgc36E+DhUGr76uNofSgLj0vU6RGI0x3ibFMFjhcZbQaL
 vJWPHfnftlpL9IqYwUKRn2pgEkyjITpfS7jz76Bwwryt/OMylk6XgrKV8iXbHZ+I34IAMXr2mCT
 P5JSKC9r22qXbHxzUdjxFMj5rGJdy5wko762Qj17G11U7Fqp3s4eeUYwVhXzVBpTOMJEByAYuI6
 3gRo3QFT9UObHEougNUnkHQ==
X-Received: by 2002:a05:6870:248b:b0:47b:3efa:c3c with SMTP id
 586e51a60fabf-4a75795eecemr1391199fac.27.1792197347377; 
 Fri, 16 Oct 2026 17:35:47 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a73b5b4291sm2745091fac.5.2026.10.16.17.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:35:46 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 16 Oct 2026 18:35:19 -0600
Subject: [PATCH v9 05/17] lib: rsa: internalize PKCS#1 DigestInfo prefixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-submit-ce-series-v2-v9-5-c24e64daafe9@gmail.com>
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

The checksum algorithm table is shared by RSA and ECDSA, but its DER
prefix fields are used only by RSA PKCS#1 v1.5 padding verification.
Keeping those prefixes in the software hash implementations also ties
signature metadata to a particular hash backend and duplicates it between
the legacy and MbedTLS shims.

Keep the SHA-1, SHA-256, SHA-384 and SHA-512 DigestInfo prefixes in the RSA
verifier instead. Select the prefix by checksum name when checking PKCS#1
v1.5 padding, include every algorithm in host tools and only configured
algorithms in target builds, and reject padding which is too short for the
required eight-byte padding string.

Remove the DER fields from the generic checksum descriptor and remove the
now-unneeded constants from the hash implementations. ECDSA-only and
hardware-hash-only builds then carry no RSA-specific DigestInfo data.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v6 -> v7:
  - New patch
---
 boot/image-sig.c        |  8 ------
 include/image.h         |  2 --
 include/u-boot/sha1.h   |  3 ---
 include/u-boot/sha256.h |  3 ---
 include/u-boot/sha512.h |  6 -----
 lib/mbedtls/sha1.c      |  5 ----
 lib/mbedtls/sha256.c    |  6 -----
 lib/mbedtls/sha512.c    | 12 ---------
 lib/rsa/rsa-verify.c    | 67 ++++++++++++++++++++++++++++++++++++++++++++++---
 lib/sha1.c              |  5 ----
 lib/sha256.c            |  6 -----
 lib/sha512.c            | 12 ---------
 tools/image-sig-host.c  |  8 ------
 13 files changed, 63 insertions(+), 80 deletions(-)

diff --git a/boot/image-sig.c b/boot/image-sig.c
index 4eab017bc2d..80a9c4325bd 100644
--- a/boot/image-sig.c
+++ b/boot/image-sig.c
@@ -18,8 +18,6 @@ struct checksum_algo checksum_algos[] = {
 	{
 		.name = "sha1",
 		.checksum_len = SHA1_SUM_LEN,
-		.der_len = SHA1_DER_LEN,
-		.der_prefix = sha1_der_prefix,
 		.calculate = hash_calculate,
 	},
 #endif
@@ -27,8 +25,6 @@ struct checksum_algo checksum_algos[] = {
 	{
 		.name = "sha256",
 		.checksum_len = SHA256_SUM_LEN,
-		.der_len = SHA256_DER_LEN,
-		.der_prefix = sha256_der_prefix,
 		.calculate = hash_calculate,
 	},
 #endif
@@ -36,8 +32,6 @@ struct checksum_algo checksum_algos[] = {
 	{
 		.name = "sha384",
 		.checksum_len = SHA384_SUM_LEN,
-		.der_len = SHA384_DER_LEN,
-		.der_prefix = sha384_der_prefix,
 		.calculate = hash_calculate,
 	},
 #endif
@@ -45,8 +39,6 @@ struct checksum_algo checksum_algos[] = {
 	{
 		.name = "sha512",
 		.checksum_len = SHA512_SUM_LEN,
-		.der_len = SHA512_DER_LEN,
-		.der_prefix = sha512_der_prefix,
 		.calculate = hash_calculate,
 	},
 #endif
diff --git a/include/image.h b/include/image.h
index 5248ca98d41..03e290ad42e 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1674,8 +1674,6 @@ struct image_region {
 struct checksum_algo {
 	const char *name;
 	const int checksum_len;
-	const int der_len;
-	const uint8_t *der_prefix;
 #if IMAGE_ENABLE_SIGN
 	const EVP_MD *(*calculate_sign)(void);
 #endif
diff --git a/include/u-boot/sha1.h b/include/u-boot/sha1.h
index c2d62e9cf0f..7a167130dae 100644
--- a/include/u-boot/sha1.h
+++ b/include/u-boot/sha1.h
@@ -28,7 +28,6 @@ extern "C" {
 
 #define SHA1_SUM_POS	-0x20
 #define SHA1_SUM_LEN	20
-#define SHA1_DER_LEN	15
 
 #define SHA1_DEF_CHUNK_SZ 0x10000
 
@@ -36,8 +35,6 @@ extern "C" {
 #define K_OPAD_VAL 0x5C
 #define K_PAD_LEN 64
 
-extern const uint8_t sha1_der_prefix[];
-
 #if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
 typedef mbedtls_sha1_context sha1_context;
 #else
diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
index 2d86508332e..4137b0c5851 100644
--- a/include/u-boot/sha256.h
+++ b/include/u-boot/sha256.h
@@ -13,9 +13,6 @@
 
 #define SHA224_SUM_LEN	28
 #define SHA256_SUM_LEN	32
-#define SHA256_DER_LEN	19
-
-extern const uint8_t sha256_der_prefix[];
 
 /* Reset watchdog each time we process this many bytes */
 #define CHUNKSZ_SHA256	(64 * 1024)
diff --git a/include/u-boot/sha512.h b/include/u-boot/sha512.h
index 92660d93357..d186238d856 100644
--- a/include/u-boot/sha512.h
+++ b/include/u-boot/sha512.h
@@ -9,9 +9,7 @@
 #endif
 
 #define SHA384_SUM_LEN          48
-#define SHA384_DER_LEN          19
 #define SHA512_SUM_LEN          64
-#define SHA512_DER_LEN          19
 #define SHA512_BLOCK_SIZE       128
 
 #define CHUNKSZ_SHA384	(16 * 1024)
@@ -28,8 +26,6 @@ typedef struct {
 } sha512_context;
 #endif
 
-extern const uint8_t sha512_der_prefix[];
-
 void sha512_starts(sha512_context * ctx);
 void sha512_update(sha512_context *ctx, const uint8_t *input, uint32_t length);
 void sha512_finish(sha512_context * ctx, uint8_t digest[SHA512_SUM_LEN]);
@@ -37,8 +33,6 @@ void sha512_finish(sha512_context * ctx, uint8_t digest[SHA512_SUM_LEN]);
 void sha512_csum_wd(const unsigned char *input, unsigned int ilen,
 		unsigned char *output, unsigned int chunk_sz);
 
-extern const uint8_t sha384_der_prefix[];
-
 void sha384_starts(sha512_context * ctx);
 void sha384_update(sha512_context *ctx, const uint8_t *input, uint32_t length);
 void sha384_finish(sha512_context * ctx, uint8_t digest[SHA384_SUM_LEN]);
diff --git a/lib/mbedtls/sha1.c b/lib/mbedtls/sha1.c
index 2aee5037795..3dbec314e11 100644
--- a/lib/mbedtls/sha1.c
+++ b/lib/mbedtls/sha1.c
@@ -11,11 +11,6 @@
 #include <string.h>
 #include <u-boot/sha1.h>
 
-const u8 sha1_der_prefix[SHA1_DER_LEN] = {
-	0x30, 0x21, 0x30, 0x09, 0x06, 0x05, 0x2b, 0x0e,
-	0x03, 0x02, 0x1a, 0x05, 0x00, 0x04, 0x14
-};
-
 void sha1_starts(sha1_context *ctx)
 {
 	mbedtls_sha1_init(ctx);
diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
index 59edcb517df..d4b97a1c16d 100644
--- a/lib/mbedtls/sha256.c
+++ b/lib/mbedtls/sha256.c
@@ -16,12 +16,6 @@
 #include <mbedtls/hkdf.h>
 #endif
 
-const u8 sha256_der_prefix[SHA256_DER_LEN] = {
-	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
-	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
-	0x00, 0x04, 0x20
-};
-
 void sha256_starts(sha256_context *ctx)
 {
 	mbedtls_sha256_init(ctx);
diff --git a/lib/mbedtls/sha512.c b/lib/mbedtls/sha512.c
index 5615248cb91..308edcbd635 100644
--- a/lib/mbedtls/sha512.c
+++ b/lib/mbedtls/sha512.c
@@ -11,18 +11,6 @@
 #include <compiler.h>
 #include <u-boot/sha512.h>
 
-const u8 sha384_der_prefix[SHA384_DER_LEN] = {
-	0x30, 0x41, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
-	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x02, 0x05,
-	0x00, 0x04, 0x30
-};
-
-const u8 sha512_der_prefix[SHA512_DER_LEN] = {
-	0x30, 0x51, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
-	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x03, 0x05,
-	0x00, 0x04, 0x40
-};
-
 void sha384_starts(sha512_context *ctx)
 {
 	mbedtls_sha512_init(ctx);
diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
index 3169c3a6dd1..5b70c971c31 100644
--- a/lib/rsa/rsa-verify.c
+++ b/lib/rsa/rsa-verify.c
@@ -25,6 +25,56 @@
 /* Default public exponent for backward compatibility */
 #define RSA_DEFAULT_PUBEXP	65537
 
+static const unsigned char rsa_sha1_der_prefix[] = {
+	0x30, 0x21, 0x30, 0x09, 0x06, 0x05, 0x2b, 0x0e,
+	0x03, 0x02, 0x1a, 0x05, 0x00, 0x04, 0x14
+};
+
+static const unsigned char rsa_sha256_der_prefix[] = {
+	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
+	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
+	0x00, 0x04, 0x20
+};
+
+static const unsigned char rsa_sha384_der_prefix[] = {
+	0x30, 0x41, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
+	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x02, 0x05,
+	0x00, 0x04, 0x30
+};
+
+static const unsigned char rsa_sha512_der_prefix[] = {
+	0x30, 0x51, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
+	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x03, 0x05,
+	0x00, 0x04, 0x40
+};
+
+static int rsa_get_digest_info(const char *name,
+			       const unsigned char **der_prefix)
+{
+	if ((tools_build() || CONFIG_IS_ENABLED(SHA1)) &&
+	    !strcmp(name, "sha1")) {
+		*der_prefix = rsa_sha1_der_prefix;
+		return sizeof(rsa_sha1_der_prefix);
+	}
+	if ((tools_build() || CONFIG_IS_ENABLED(SHA256)) &&
+	    !strcmp(name, "sha256")) {
+		*der_prefix = rsa_sha256_der_prefix;
+		return sizeof(rsa_sha256_der_prefix);
+	}
+	if ((tools_build() || CONFIG_IS_ENABLED(SHA384)) &&
+	    !strcmp(name, "sha384")) {
+		*der_prefix = rsa_sha384_der_prefix;
+		return sizeof(rsa_sha384_der_prefix);
+	}
+	if ((tools_build() || CONFIG_IS_ENABLED(SHA512)) &&
+	    !strcmp(name, "sha512")) {
+		*der_prefix = rsa_sha512_der_prefix;
+		return sizeof(rsa_sha512_der_prefix);
+	}
+
+	return -EINVAL;
+}
+
 /**
  * rsa_verify_padding() - Verify RSA message padding is valid
  *
@@ -33,28 +83,37 @@
  *
  * @msg:	Padded message
  * @pad_len:	Number of expected padding bytes
- * @algo:	Checksum algo structure having information on DER encoding etc.
+ * @algo:	Checksum algorithm used to select the DigestInfo prefix
  * Return: 0 on success, != 0 on failure
  */
 static int rsa_verify_padding(const uint8_t *msg, const int pad_len,
-			      struct checksum_algo *algo)
+			      const struct checksum_algo *algo)
 {
+	const unsigned char *der_prefix;
+	int der_len;
 	int ff_len;
 	int ret;
 
+	der_len = rsa_get_digest_info(algo->name, &der_prefix);
+	if (der_len < 0)
+		return der_len;
+
+	ff_len = pad_len - der_len - 3;
+	if (ff_len < 8)
+		return -EINVAL;
+
 	/* first byte must be 0x00 */
 	ret = *msg++;
 	/* second byte must be 0x01 */
 	ret |= *msg++ ^ 0x01;
 	/* next ff_len bytes must be 0xff */
-	ff_len = pad_len - algo->der_len - 3;
 	ret |= *msg ^ 0xff;
 	ret |= memcmp(msg, msg+1, ff_len-1);
 	msg += ff_len;
 	/* next byte must be 0x00 */
 	ret |= *msg++;
 	/* next der_len bytes must match der_prefix */
-	ret |= memcmp(msg, algo->der_prefix, algo->der_len);
+	ret |= memcmp(msg, der_prefix, der_len);
 
 	return ret;
 }
diff --git a/lib/sha1.c b/lib/sha1.c
index be502c6126b..4f35850b384 100644
--- a/lib/sha1.c
+++ b/lib/sha1.c
@@ -24,11 +24,6 @@
 
 #include <linux/compiler_attributes.h>
 
-const uint8_t sha1_der_prefix[SHA1_DER_LEN] = {
-	0x30, 0x21, 0x30, 0x09, 0x06, 0x05, 0x2b, 0x0e,
-	0x03, 0x02, 0x1a, 0x05, 0x00, 0x04, 0x14
-};
-
 /*
  * 32-bit integer manipulation macros (big endian)
  */
diff --git a/lib/sha256.c b/lib/sha256.c
index c2e77c854b9..b99f8105c8d 100644
--- a/lib/sha256.c
+++ b/lib/sha256.c
@@ -13,12 +13,6 @@
 
 #include <linux/compiler_attributes.h>
 
-const uint8_t sha256_der_prefix[SHA256_DER_LEN] = {
-	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
-	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
-	0x00, 0x04, 0x20
-};
-
 /*
  * 32-bit integer manipulation macros (big endian)
  */
diff --git a/lib/sha512.c b/lib/sha512.c
index 0e75c1a943b..06d9b5564f9 100644
--- a/lib/sha512.c
+++ b/lib/sha512.c
@@ -16,18 +16,6 @@
 #include <compiler.h>
 #include <u-boot/sha512.h>
 
-const uint8_t sha384_der_prefix[SHA384_DER_LEN] = {
-	0x30, 0x41, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
-	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x02, 0x05,
-	0x00, 0x04, 0x30
-};
-
-const uint8_t sha512_der_prefix[SHA512_DER_LEN] = {
-	0x30, 0x51, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
-	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x03, 0x05,
-	0x00, 0x04, 0x40
-};
-
 #define SHA384_H0	0xcbbb9d5dc1059ed8ULL
 #define SHA384_H1	0x629a292a367cd507ULL
 #define SHA384_H2	0x9159015a3070dd17ULL
diff --git a/tools/image-sig-host.c b/tools/image-sig-host.c
index 285547994ca..7145637a8b8 100644
--- a/tools/image-sig-host.c
+++ b/tools/image-sig-host.c
@@ -16,32 +16,24 @@ struct checksum_algo checksum_algos[] = {
 	{
 		.name = "sha1",
 		.checksum_len = SHA1_SUM_LEN,
-		.der_len = SHA1_DER_LEN,
-		.der_prefix = sha1_der_prefix,
 		.calculate_sign = EVP_sha1,
 		.calculate = hash_calculate,
 	},
 	{
 		.name = "sha256",
 		.checksum_len = SHA256_SUM_LEN,
-		.der_len = SHA256_DER_LEN,
-		.der_prefix = sha256_der_prefix,
 		.calculate_sign = EVP_sha256,
 		.calculate = hash_calculate,
 	},
 	{
 		.name = "sha384",
 		.checksum_len = SHA384_SUM_LEN,
-		.der_len = SHA384_DER_LEN,
-		.der_prefix = sha384_der_prefix,
 		.calculate_sign = EVP_sha384,
 		.calculate = hash_calculate,
 	},
 	{
 		.name = "sha512",
 		.checksum_len = SHA512_SUM_LEN,
-		.der_len = SHA512_DER_LEN,
-		.der_prefix = sha512_der_prefix,
 		.calculate_sign = EVP_sha512,
 		.calculate = hash_calculate,
 	},

-- 
2.53.0

