Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DB3606A321
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dHrhdJUT;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZejUOgQC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A95174054E;
	Thu, 26 Nov 2026 10:52:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IkXbKR02DAOZ; Thu, 26 Nov 2026 10:52:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 19C9E408E1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795690340;
	b=juZuVhLlqf1p7TFFJX4NS7CWUkxMYOkEl7oxc6W2fgzbef7ugAXy9Q5K7DMbsN5rEh70
	 Poc5KKu52Jch0TIx3SnSYbro7IsSlLz6GwDlUmNW8aUeRoyEXcoR8Np7ZDcn5OihPbpb1
	 1RVx/pMMz1DEU3LKQim9ticb84NcIXFSJ3FQyIP+bts9L/+KQwHb6hVWAp6kz0RvJuQfg
	 WHcs9LecMV3YhywV3nWLNCLzs9BwD+l0cNBJJsZOULyN9GglQrXSdicihbKu+KiXz8Jxg
	 A+FDUCW0YEiyTmvKZSc7m/AHzAnxMB9OcPUILeZndOBkymfqz4Phzo6h7sfQWI1mt1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795690340;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/CoXy/ZhGPJCbJjLncsTy8bZZpg8sqAuOcEDWqD5rNU=;
	b=S2ImYC117XCpe/W2Cji9UpW+HdZj2xwarKC8if9dgsvIjUx5nsFGXQy5XdYwwEnAt/TE
	 fSrt7NstXPt8iVuiM2wqAC5WoD5E2lKyEuoTmv+/F5iyIfipSd0zXhatL7pzYxfJ21LkX
	 xxE6eMCvn8bXV3vBIOyAEqFpi6kZjpXVBPfmDrxGSlCfAx0HaYHb8askeqbQL1mbLHpTY
	 jW1SogOJ3HpewJ9gudQXMyo0kEXJFmv3fxazIru/Qs0uPfs1c0SpL79kfxUvJaqKgsX0L
	 27+d8EULQMcw3mG9D84YK5qyH+jdXZ8n84VToE72g5UsFuPwKN9OPbYQKNjIFzGoZyw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZejUOgQC;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795690340;
	bh=/CoXy/ZhGPJCbJjLncsTy8bZZpg8sqAuOcEDWqD5rNU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dHrhdJUTk2OxtMHcqoCH1dTghvYcYuKPOIIgRGUAc70ffXntV0BEkAFGW+JAdsgKt
	 f1MryYkwrEV8qI80Wkde4wH1aFGdKB5xZN5DBMYqQTCnTh/VWPpFK/9gN156i0I/F8
	 UUGfC3qa3N892fmvb3I6ByndAZq8hHwSR6DTzPNSniRBKGz8Tz+3XPHxnjb0Hgr6Wm
	 AlHlmUiLJQQAWz8jgIoSoZLn3OAqSuoQ2IxbCygfpNtohr12J6KecWc8r4KVIvZ87c
	 7VJPvJQoyh1aa+NhqoghbfYsm3vAPiczGfL9baiskFnucJijiNaaYKrcsDTR7CjoK6
	 g0n/Lxe6F+7ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19C9E408E1;
	Thu, 26 Nov 2026 10:52:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C19C210B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:52:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3859408E1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:52:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zfccLHmjmtZV for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 10:52:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BA2544054E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::12c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12c; helo=mail-lf1-x12c.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ZejUOgQC
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BA2544054E
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:52:17 +0000 (UTC)
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5bcdae234ecso1426380e87.3
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 02:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795690335; x=1796295135;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/CoXy/ZhGPJCbJjLncsTy8bZZpg8sqAuOcEDWqD5rNU=;
 b=ZejUOgQCgqI94lhAn/GoX92EUt7H0qjUQDVwseaURLqDT7OIWjCbjVhGOvuGM0gZ0E
 1EiovRsA98yZ1JB3CHPOyyjgDwUjk7OXcDjWmLiXjfBm/fzTChr2aOQQe9GtbLlky9yN
 b81QUPS0m/3CDmDiRjf13Q2Mk1NkHOCTVA6GwXFJlK55VIddBXPEWrmTP3Qf4wdDrEDb
 cKX6b3r5Xx6hn7jZixAUvK+e2su5yc+2wIrJkfLrBictSGLyHFnyGy/M8RGCHcf0+ZxM
 GmxfRbpNaJbtgNfC+/TxDTIRqybnRgLJLT4AYD63+CnvcwbkdKpwvlpil9fIFfETMPwR
 hnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795690335; x=1796295135;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/CoXy/ZhGPJCbJjLncsTy8bZZpg8sqAuOcEDWqD5rNU=;
 b=XZJ1VgDwvt/IxOO2iT36wZkg2J5gXK3+WQnBinsq/O/A6VziTvCjjcDJ186CmHTlcE
 RaZVjh55sRLSoHndyNosxlveTgYTc/AmUrE7qehduOj5mVAn2VjDbhluU+XUvtetsBW8
 hOVNTEBzj+WFuXG99GBQWZQkpjHgZgBqjDUDzbmK5qWpnZjeMOWqR7Zh45Q/hdq1mGk7
 CAHy5VuXZxb5WfnXMhRIt6TGp5KOI/doRDHBrCk+wnbt+zSUwYVag+h+OzFdNsj7BxJu
 sz5SIl88SdloA+6obBPO0sZAdfsR9/paTTTKuO8sr+CfvNTWb3ggS0YnHpw32o4opn7C
 b4Kw==
X-Forwarded-Encrypted: i=1;
 AL+hErExWKfs+LfgAUsl4A49P5qK578hYn13+Pqo3cazTuoSgqQ0jOARg/8bqSchRLxVNuS+JUeb/gM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z994eY2F4aoTHMOkQq7jSQihvZUOxgi/yWHNYB23+EJGxWiJXji
 W83A9OFVfEpisEwVVXJeVOhsqVPnj9uU0OQbCdVGuBHEE0NpUQnYHkL+4yDG0tYdInsJqnNLirC
 yPu2tQ8dghAi9vaYqtQU/EPaMNefbDoU=
X-Gm-Gg: AZFdTZcKz+mLOSLdyxGHtYolvE5wENy3TlRoWR6HcuzTwD1b21qV7n8xWfaQxbD/SHu
 Akmih+Kwny1lKhlcXkezQ6fYEXOxo/evklASy0YUBiti3t+sdes8K/umz5ZsbAoL5sPOgKqvDsd
 vWM6ZSxTYnFeQxKYTB6Kbp99QpngyacEucnCPyI65kifeYp5FfyXxMGaaTbTLrot50GzLkFtuFN
 DzWo79tEnFlhHsktoUItwe7+R03kbqdEidfEp1HtFaB+phYzowPx2Fg1MHU58sLW2eYME//wk8P
 KduBc5A6XQC+w3klrhnYRHtxtlU1J0+owDlqKtxECGe2paoAGehiktq0LmTAWiKtMHufhuakvcH
 D9mDNjCZDAURTXglBywLDhtGuRDQEowrV5ZRaqkK4b2hGtPFgJAGCUoZpRG4CczOabTYX/8kGbk
 x84x1M00/UzF9kISloYW9hSHT3a+2+wEkmau27NihB1yTf60ER
X-Received: by 2002:a05:6512:6685:10b0:5c1:5cee:632d with SMTP id
 2adb3069b0e04-5c1bc7d33f7mr3852068e87.32.1795690335208; Thu, 26 Nov 2026
 02:52:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261126-update-tqma6-v1-0-a105aba78868@ew.tq-group.com>
 <20261126-update-tqma6-v1-3-a105aba78868@ew.tq-group.com>
In-Reply-To: <20261126-update-tqma6-v1-3-a105aba78868@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 26 Nov 2026 07:52:03 -0300
X-Gm-Features: Aa3M54q4SIucahpzYd4II9hrZFRElAqLUGKJ79-0hxAQcY4PHze_GGOjU_iwhfQ
Message-ID: <CAOMZO5Au35UKfYKAXsvJeb6osi19cyLYDQbO4B6HqddEhVq5xA@mail.gmail.com>
Subject: Re: [PATCH 3/6] board: tqma6: add SPL support
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Paul Gerber <Paul.Gerber@tq-group.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Adam Ford <aford173@gmail.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, Johan Jonker <jbx6244@gmail.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Paul Gerber <Paul.Gerber@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 7:47=E2=80=AFAM Max Merchel <Max.Merchel@ew.tq-grou=
p.com> wrote:
>
> Update defconfigs to use SPL.

Same here: please improve the commit message by explaining why we're using =
SPL.
