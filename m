Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7D2606A31E
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Nk4hlTUV;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=U7vFW+tW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A57B780E02;
	Mon, 26 Oct 2026 09:56:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iOj_qAhFxLHn; Mon, 26 Oct 2026 09:56:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C721080E04
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793008572;
	b=lUNQgnoyEObflOlyoIs4CHfhjMZX2BCReaXZRbZ9B2ExTJr3KIdNVwBH38dULt11y/Sz
	 rKdv5d/oNRDncTtcGZPP5keABrThnxjMC+as81DwtjlfWRjaU60As7wNbOTmUhsHZ5nQt
	 2WO4LtDCYt5k4zhfE1JlX6BzH6F7mLQqDHdC4OOHZ16q+1n9AdXKLxh64b+aoL9GKi4Dz
	 6svbTdBadT+sZ6rhkssK+HLJ933H8IBdT8AUqlv9321VbRy0RDJF0cHy8uFooYzM02LXQ
	 pZTTOnoBvgrPCB3HeV7DH4deKENJpFjP9HFPRkYUkYsIVbdcB/Nt9i0gNdXw3a7te7A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793008572;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QhjX4aRosdeHLl7uHEaTgW3Zp7T1oHn6LAZanrGU0PM=;
	b=iuYp7Xr7K6wInBxicGyKR4T0H0crmryBoiwyJfKx8PV3DxVYIreoJahhtgF4lcW1lpNf
	 E7Uelo0UWwxSgiLfxj1dl+YmIho0uLNUtFSc/OYpCVhHYd7ZqnFVRum+WEGSPNVKkMpMF
	 obkkwAohfowl+g9wHPUs3ZKS4huFfNO5V24uB0JnZfxDnzyytbnrMcGQcs5wDQFMiNZqw
	 /yTIf+2clJtt30d4MlfKutb4ABWQYgog/6qiOtcKVkIWf3i/n3bjC0zNF0RxVZetcmXsB
	 16ZxuOVRG80gxHk1LuR8Hq+D/ACMjNchBGM0LdQ9MBocT0CJUG7O7XsklieTp1NnfrQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=U7vFW+tW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793008571;
	bh=QhjX4aRosdeHLl7uHEaTgW3Zp7T1oHn6LAZanrGU0PM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nk4hlTUVzRfyaa0C+eYPjBWYiXLe9So0Bg1b4hCz8wzhDgMXw9xRV71EKPvVH10F3
	 uJ6bBWIrjqzIwUaXN3RJF3mEUcHAnxsAAD0nkt4pregtZLvlHecWQrR3RZ1Z/wYTjY
	 c8hMkoCkan+gZUmxv3+QNKw9tqFY5OXEvN9wAnhhE4wSvrbLSnVRzSViNOFwB8fVfi
	 Rzg6d4C9uzGVHxNzFA4k6xFc+zSgBq0ChqQYWz1WfBbTUhxTYH1EwArBsK8xiMHuPn
	 0tNV9+OGAUK0xVhrcjqcfte8TZqT9wNCuDLcX02gxoLVtfcKPjtwKoXGae51Qo57DK
	 kCm+8Ts2uDv2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C721080E04;
	Mon, 26 Oct 2026 09:56:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 20F14279
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:05:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 070F080DA4
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:05:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hMIK5gReDRT1 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 09:05:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 38BFA80D43
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793005536;
 b=JC/UTyZ7FpVWn+YkGV0kFIZJt5FCy9S2Pf1cdo2bFVL5JZU7QPGkOCRfcWdN56dE/USx
 TH1X3RX9Tl/NPMFrAvmlbVN4pJD1l4e2bKikZtUw//EDE/R7oXe6PwrpV1hG+TSNoSzW6
 T23Vy2NU1gAM4pI4+H0sksg9xonmDXrAM+nAqxqnLrux6FHZFDIcgY6pKWIVFx/jv1M9r
 j5ZPS6RY70dWnA92Sc2d55YW5LHNQUz+ffJmHAa13FLQLj5yQDI/Y3e8bRVBtNo1+VguJ
 sRiKVtbJN9fKpJ224C82O/Jr5//gm3wbTP9pA8yNA6PBeZuqNy7f4i55UvDbYxkYngg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793005536;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=QhjX4aRosdeHLl7uHEaTgW3Zp7T1oHn6LAZanrGU0PM=;
 b=SRVOLS7Y8Uzre1E776PHtcxtIq+6rrEGCowHvBgRJoMpCfcu69MqVUFiBFnTRjnMzoBh
 Vtj1Tg1sjD1e0FJkIfrj7Ax2MkXYEWm8iM56x6L5qDk3QvDRxegpxTkFMSXYoL4Y/ORqf
 CiZ9TYxnTqVx94vXqnlUwC65DQBzucN9vKU3VlMATDQIpTh6XY5pWytT4U8Vdsr/CFQmT
 wt/5Ng586HTgpQVoSV0HGKOucaCbDs2xcbRC2lX2s7jjHHV32QBUfstOaytLu73BLe5ct
 r6sIoscnvVOl5tYLRKXKdIH+s0FZOrIKeGDzCIcrLmVJyXH7l0XX8VFHCfmlBjfF0uA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=U7vFW+tW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=U7vFW+tW
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 38BFA80D43
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:05:35 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-ccca948203aso746103a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 02:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793005535; cv=none;
 d=google.com; s=arc-20260327;
 b=WX90xvf92MDa/PlVi5hgyx7sM1lv7JPvB1G3afuOnqsg9gqx4XxPt6t5rCh864kjDz
 MYElJpft5lc6VvZUdSRWsHIeC9NCy6/nbn4Fcc3VWX4r4HsFNknGiM8ODV4HOUI/jPUf
 65BmKYI3LgWj4kXEL6A14oiyJ/3gMJ0gqMEMQwdnHWbmoXlmpHWmhkjpoMhWHIMgGSz+
 6PmRctjC94vXOhRAgMKQK7TB36vaF1SjcitCfbDbsWz7tYIMS2FHIbo1ebHzA2r1qCM1
 +BUr4UWKgQygAxm+aky1Vhei2H2JVVjU6CgK1Jad/Bu/pDqNrl5prIwsNG5iG+qLLe27
 jZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=QhjX4aRosdeHLl7uHEaTgW3Zp7T1oHn6LAZanrGU0PM=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=Vwg/3mq4RMbYYptSgy+gqdpemHlsxcvpVOUDpsf7SJmwQvoKglcR72MRwVv5n1vrZh
 26iFArGfzmilrhwiBMCwAZQZkz2JentBNY4mZc26vh09LNWp2YoCDcKk0Kanx1YIrjh6
 ZKN8NGoIQL3qHRpeDXzwP3xD8rCaSeeZehgwBPrkFhIu3P6fVFjdN3W3obtrSyj7nB1I
 YXLyjUX6IIF0OwltDc5UpnqJv4V0axe2C62ovIsaHRce56dy+AyUVFlSPfuXLmSqF8Ji
 GguXyvp+wLxdCtcXsD1BAY8WwCBE/dVmWSII7XUl/CPT/NieAxcaP/ghB3a65lpUeWKX
 SW7Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793005535; x=1793610335;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QhjX4aRosdeHLl7uHEaTgW3Zp7T1oHn6LAZanrGU0PM=;
 b=U7vFW+tWZu2n5kign4yZosH/45HvZs40FYw6v6zjV4qfiKXZ47Hl8+Xh+0Tuwo7DDX
 9hI6cfyZVu+9/+VkxZlQDcYH+KjUuvv7qlZNnjYI6r+fm23YtIuOVCtuQj+hi7JMn4D3
 zleO6F2mshOHpvEkorY/GwbREf9hgICa6fFDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793005535; x=1793610335;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QhjX4aRosdeHLl7uHEaTgW3Zp7T1oHn6LAZanrGU0PM=;
 b=sIyAU+CbGWDPoZA2CGGoRc3M7ILNzJL5K+0XwnQKRC81lE+yY2ZeOOJBObRN9lHsKy
 3Z35/0h54QdTwiMYgZqV1z+ba+xpFfW3EuaXMEF2XbH8lWuqw+GDbidnmLvsooiE/DB3
 u0BtUe1tkMC+LoprFcZVADQnUPYzB8KjDB7wUFOVkW08+cjpF8qs3Y5n2IHOzMQd9tM+
 FYsy+054qJMdxhNNhYxPv9qpKixhy3tffEtY6gSekc46N2jzsTtJ9jt+ik52esYnZUv+
 UNgaxEghk3xAC5lsiplB6R96tO5PeBRzxoFCHEJBqFiv1rhUerRmgKbDQB+wK4Gt+zbt
 LX8A==
X-Gm-Message-State: AFq9FYIQx0L7LyQqpKNhRNv95mHEtZVrUcpneLZTP5c1/PcmSchPVy90
 uVT4Q/Q7O5BYjLajTIJrTiUoyBrX4jK19q3d+j0x7ky0mN9UB4mkUH3RqzGT9KJ3LTgmE2qMwaI
 yWH4EMWIcXLk4kTS8rQlxD+SxyWdnIKufVSMhsiYV
X-Gm-Gg: AYBFou006FI+3vyhj4W5S5yJM/qI0000jMYwdFIdol714wK+hQ2q073ktnUOEoaEBxM
 IYg9tywQqJQ9+OmDFH7KssmcYd2R2d4WKaO1wQVwN3Xh3F6cSG9pFVZZMxEmN6uCKPA22yGV8ST
 MJLmd9Lyfw7SoA/hBevQdDfPy3yY4ZLYMxSYye5ij2bQsqi3aMJ7LCnSrHMzF3kG2bDudcuH7u3
 IzphHKW7BpzmXui0mv2usaKy6x00uZykYK+I/eunCst2CHz6OAdhk2D0LO17cv4ejQcMHJ06yzd
 fOD2WJQiPv9qWZny4vnF1vd1Euw/R2gUZ4cMRpmRV5dQIWcN/fBsDlhrK1KcdQdNsBodtFSVcIW
 0Z7ZOosJ3VMpxhTQSJckyGHi6Wfh5KKZSKiY=
X-Received: by 2002:a17:90b:2e8c:b0:3ac:8897:7b9f with SMTP id
 98e67ed59e1d1-3adeae77a16mr4964927a91.43.1793005535088; Mon, 26 Oct 2026
 02:05:35 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 02:05:31 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 14:16:37 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-17-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-17-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 02:05:31 -0700
X-Gm-Features: AclHuK9Vw4iTPwb3VEhYkJyXT0LyxSZEJYX1XnxLvcWDDyOy6IfYRWZcfUznWSo
Message-ID: <CAFLszTjCRS2VD-b9AGt6RFg66fVFF4FyPA_LX9Bo9HOKkThQYA@mail.gmail.com>
Subject: Re: [PATCH v3 17/23] test: spl: Cover compressed data overlapping its
 load address
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com, 
 Petr Hodina <petr.hodina@protonmail.com>, Bruno Banelli <bbanelli@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 26 Oct 2026 09:56:09 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> test: spl: Cover compressed data overlapping its load address
>
> load_simple_fit() now refuses to decompress where the staged input reaches
> into the output, either up front or once the output size is known. Check
> both, using the image a passing test loads with only its load address
> moved: onto the staging buffer, and below it by just the input's length,
> so that nothing else can be what fails it.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
>  test/image/spl_load.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)

> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> @@ -483,6 +483,75 @@ static int spl_test_fit_external_oversize(struct unit_test_state *uts)
> +	/* Right at the staging buffer, the overlap shows up front */
> +	ut_assertok(set_fit_load(img, staging));
> +	memset(&info_read, 0, sizeof(info_read));
> +	ut_asserteq(-EINVAL, spl_load_simple_fit(&info_read, &load, 0, img));

This doesn't quite show that the overlap is caught up front. Without
the first check, the decompressor would write over its own input here
and could still succeed, after which the second check returns the same
-EINVAL. Please can you check that the staging buffer still holds the
compressed data afterwards, e.g. ut_asserteq_mem(lzma_compressed,
map_sysmem(staging, 0), lzma_compressed_size), so the test can only
pass if nothing was decompressed?

> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> @@ -483,6 +483,75 @@ static int spl_test_fit_external_oversize(struct unit_test_state *uts)
> +	/*
> +	 * Just below it by the input's length, the input clears as much of the
> +	 * output up front, but not the whole of it, which only shows after
> +	 */
> +	gap = ALIGN(lzma_compressed_size, 16);
> +	ut_assert(gap < SPL_TEST_DATA_SIZE);

Just to check: here the decompressor really does write over the start
of the staged input. It only works because the canned data compresses
to about 0.68, so the write position (produced - 2800) never catches
up with the read position; if it did, the result would be -EIO, not
-EINVAL. It would be worth saying in the comment that this relies on
the output only overwriting input already read, so nobody changes the
blob or the gap later without knowing.

Regards,
Simon
