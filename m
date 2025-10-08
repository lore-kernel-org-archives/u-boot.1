Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E300DCAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 15:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 756FB84054;
	Wed,  8 Oct 2025 17:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kIRUbu+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1259384073; Wed,  8 Oct 2025 17:03:31 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70658839DE
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 17:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-57bd04f2e84so8444105e87.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759935808; x=1760540608; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YOZ5ql+B3UKBiLKjHZt8F+lQRLr/b7cXc2mcMARTloY=;
 b=kIRUbu+1ug1/5BK+U8cFwRDp/EoZYO6HPSXwR0Q9bLzSA5Y5PPnThuEy3fDILaJptl
 D8U+P6RZ90IYftapv8SRRaQiHi4usvIRWULnO2k/Z2sEmxKXyOnlPnVbVrtFKZF7OKAJ
 +ZaKTX/Fqjq61rrXM+jBUyvYIuCJg0T4Z+BcPx7m4aBzSMCpAsrNe5NOYdKjkj9lM/Nc
 eFh4OsRtG2Xzj1NFeZarhMhdsXaHxB5vzUF5nqEe6MGkU3RUy++Ykwx2ZcARt1VF0qbB
 ZZykcylRAtdEj2uB7jbEM4Iufh0eReeHu7nv2Ckp6ob4L9AZEheMFzD6kt82s2OwpxhW
 v8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759935808; x=1760540608;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YOZ5ql+B3UKBiLKjHZt8F+lQRLr/b7cXc2mcMARTloY=;
 b=s89TYmA8+wMXT1STukJgiECAasYqj7EQX765p4P+QeTAoGOqmwWXk7gkpdM44nOYiM
 c+sN2+Dp+tmWUKvO7LSYGg4rlO0sAKmp3f4wyHBBNZ9iTmJO3YG7o4ayfa3gt6rrEH1A
 B9vRlNWb9mTRhOeKXTVfOknlMRo6g6sWu8x8WrAcKlhq2e0YvYeUbxV/N5RNx4S7sJBt
 9GAANuvAlNbihfKBMeXd8KBgK8CeRKOtunMnMkFiRRh1lxl9EURHB4AmySEki+b6AoPO
 J5sSAemspOxafKkExBtROoOsnocjHO8hLBl+h2jT4BbCdx7W4Z5PRkvsSzXMB2INirkL
 QNLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfCyH9eTVMbhMuDZCgs1beqQ297kcT9zPqKrUrDPO0xBYAfOm8W1/R7yEw9MoxnW+TSvIHALw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+npCKLml+PTX6KfydYk1Hz/sS4QUTMode7vrHesb3DIl9aVIQ
 GtbsyA/gw8CDn32wYFKXAEv/feVMPORaeaQCYnYktocMLNCTwok/zyW4/mlzpCgr7FbzNFUq5Kf
 zOgIGaKdFEe85OQ5owLpDR1pLb540LdA=
X-Gm-Gg: ASbGnct/LJhZr8krRogqmM3h0pgIzKXVrhQQoe+R9gJ9w9vApct1lRhHYVOQsfkLfye
 aAUAwebQdHg5SXYOq80yMzr2MapU6tx2B8YnaG5Ex9OapZccHNcKa3gyXjeIX2SlMp/EPAG9byJ
 kEhDrc15ouRdxSwy0lAXdiSJDnQZZIHgHzkAWlrD0ApKeLTZrMhCAeJsZ4rFiuPzUGl69p1HLU1
 C8pb/1ohMTft4ZykAfWv4PnD7IVmXYtEfxEp1fnjMMY9njMIkQUbm5LFuRfAawXlA/LvwsosQ==
X-Google-Smtp-Source: AGHT+IEzhmMTJH6cNm2samE9bygt2KGnIi3NGUfJLHaBt6XBDiTEcrnvj/j4DiyZnD/bd6rR1Vm/ZKYMQyECFT8hdi4=
X-Received: by 2002:a05:6512:1309:b0:57f:8d09:8277 with SMTP id
 2adb3069b0e04-5906dd77916mr1100420e87.44.1759935807009; Wed, 08 Oct 2025
 08:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20251007074503.21624-1-ernest.vanhoecke@toradex.com>
 <CAOMZO5CU5BtAa0DVjSOSa0-Sg2G1CJ6m49VVj2QHWh1=qCC_cg@mail.gmail.com>
 <aqiht24bdhy77o4b3uk22kyzjcoki546ea56jskrowfpgjb4dn@fqbaeq3truy3>
In-Reply-To: <aqiht24bdhy77o4b3uk22kyzjcoki546ea56jskrowfpgjb4dn@fqbaeq3truy3>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 8 Oct 2025 12:03:15 -0300
X-Gm-Features: AS18NWAz3btt_yrSWXJmO9givjtIr0TtqUU72ZyAoCBKIbzSVdW2rsr9S6iUsOA
Message-ID: <CAOMZO5DLtw0Y-neJAYC7L3F03QuFX37Ksam9iP7CwdLzgFgx6A@mail.gmail.com>
Subject: Re: [PATCH v1] arm: dts: imx8mp-toradex-smarc: migrate to OF_UPSTREAM
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Wed, Oct 8, 2025 at 11:31=E2=80=AFAM Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:

> Yes, that is correct, I will incorporate that for v2 if you prefer.

Please send a v2.

With the change, you can add:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
