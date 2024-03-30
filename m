Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96322C6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 17:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA80188290;
	Sat, 30 Mar 2024 18:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g8mf2voF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E601588294; Sat, 30 Mar 2024 18:37:40 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D81D687E4D
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 18:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e6ca65edc9so878261b3a.0
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711820257; x=1712425057; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+uGy1s8e16mwckTTrwvcffLJ/dI7XhAqKLH0DZSQdM=;
 b=g8mf2voFya3d/9HpEkzHrAglspUXhSWO+00pZNhuVV4pr/BrrO9cqjoxK0RA+Xxgau
 taYebcza97d6xq3IMifZ9NWFJSQkyCx0bgAHe/AZQrXKgdmGuxuzga7hxJoz+TQFEJaq
 vibtMAp1cFVrEEWFZR02vfBwNYz+341tjZL/a0zuTnudXUU57/T1VFa/x7dHOdpJH6xS
 93Wke2+VA/CYK+RFfnyysesXtKQgii+Xj6iql3JLnphO72LTpE1IRT4Rado+9CobZC06
 AB0b5m4RAhCUGoVBMv7cAl8wvLQQRP5SA+PpYeXytxKEmQGK/RF4BJ+5roPzKpOR5JFB
 040A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711820257; x=1712425057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+uGy1s8e16mwckTTrwvcffLJ/dI7XhAqKLH0DZSQdM=;
 b=sZsmLPMwSACLGhFiwTHpP8+CDTxKwRd8LUjnPQuQvuR81UisOWbagAnHr3o68BHKoa
 Ibfr+NsguvqyT6NxfttWcCIGz3iTdWT58D09rnIM/tzSVNbw71EITeMXnvD1n7tCYwgS
 AHFhP8QofZmn0DXV2osh6SiLEPCamR5Y05ruyVaLbd7H14DR03eim3xwxbfwS8z92yAr
 wIfxZjfrQR+Gpk90nxl8sazZGUheP2zpg3rc18D3e6LBxn4jKsIcEbolVZwpY9deuPGL
 VLooewAzZ6F1yMdP1JBmjSn4eiN36tve4nl2wTdsSgcc0mNkKXx9mfjKE9w0Oi4ncTvw
 zTIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZjDkGl6rYF1M53EeeoKlb/IGSbZk9xYlXFNTNcJ8U93BELXHdsVVEm9EkN9AmNVfY4X9gqNHcpOCxBz+NO8tVgwtX6A==
X-Gm-Message-State: AOJu0YyKhwnu1gRW/plt8bKoo1PkhzXtapPhuX5PSnewBllU7RwhR4lI
 1Wq5MF7Km9BG+Bj6oftYR5odVYIwk7OxBoce9/EhAIvSQ9sTe3pOp6VdBep0Oa6mhI3VOK7aFgb
 L+LGf7qvwpwYEI8quoB36EYFnkX6S0g+6
X-Google-Smtp-Source: AGHT+IFdBy+/iW6f+GTS37uINSHHfn7p+muhsXpGQCxqbthX3ld8ImvGKrgj/U6KD8nmdmxdKCDdmPK5vXK9plwUqFo=
X-Received: by 2002:a05:6a21:338b:b0:1a3:a9b7:2b47 with SMTP id
 yy11-20020a056a21338b00b001a3a9b72b47mr6901265pzb.0.1711820257450; Sat, 30
 Mar 2024 10:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240327134651.2113527-1-festevam@gmail.com>
In-Reply-To: <20240327134651.2113527-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Mar 2024 14:37:27 -0300
Message-ID: <CAOMZO5APm2Mhjqb0Bph6r1ggNehLqUi_dZtbi6789zmm7gJNBA@mail.gmail.com>
Subject: Re: [PATCH] warp7: Convert to watchdog driver model
To: festevam@gmail.com
Cc: trini@konsulko.com, u-boot@lists.denx.de, uboot-imx@nxp.com
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

On Wed, Mar 27, 2024 at 10:46=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
> the 'reset' command in U-Boot to not cause a board reset.
>
> Fix it by switching to the watchdog driver model via sysreset, which
> is the preferred method for implementing the watchdog reset.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
