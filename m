Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53619C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 14:49:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01F3480B95;
	Mon, 24 Aug 2026 14:49:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6pCDch6IlfEs; Mon, 24 Aug 2026 14:49:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787582993;
	bh=07oNjsfBT41jW5cN1JTWMqNHCChA3JjpYE4IFdMvip4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y9yDDpf9brB1axbpfYkCnRDehdFpUOaBDQeX3kmSarfyhljACobYl0qvMG8JldraE
	 UXeUd1GQ+7fAFnR69YDal6a92caF4QjfVjXWuHn2KcxqkJykte3mcSB05rD0BBfbcQ
	 3G3R31NmS+SFhKNzrSzFpOb2hTWPz3p/qPeiE2DSZQ0RRZXMLiLkJcfcLoVOv9sR1Z
	 omTMJ8n0S/WeyMJulwlqURMcVbHa3MQuEcfP+gKvMWBB0PegWu3C6tWcfXABE1DZ2o
	 tQHXqYIYHBaIO1DbGWcwYJ78jDpT+UqyIMiVkBecuOIvVHrbHbhj8duX9i2EYoZDBy
	 BsFmUGHlpiydw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3870380B42;
	Mon, 24 Aug 2026 14:49:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22F5741A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:49:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1521D4060C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:49:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gW2T2P2YgKdL for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 14:49:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=f4crgqN3
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 762D14060B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:49:49 +0000 (UTC)
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-836cde02992so43163037b3.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:49:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787582988; cv=none;
 d=google.com; s=arc-20260327;
 b=NPkSMXBIQdQvWoCywlt3dtw93VjbsMmgt5XlsBLO30R6aUlROyj0EDMj4h/VUPSCPk
 veSjVp15kLXfngs5nsUuL2/wObA1RFwXu6WrDQXBBBHq0TMw5roQm4cat/dbrqDpHSBh
 6Xout2h4/IKzjh30wChsqogqSY6HSgIQgY0XY30zlx1Y3Yib9mR8Ebi+RQ5J99k4q1RI
 fJIy6yS2U7AMoQ68pc4En1YWmMPFAZqzP88ENH4NL3eBE8XO2npebXso99U4pdLXZRJK
 RMPaTBJ5c311DEZsrXshfVATkwOpB+AgYijSOPj3fIZqx/CLABn3PfbMTTQveJxqMDcx
 w3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=07oNjsfBT41jW5cN1JTWMqNHCChA3JjpYE4IFdMvip4=;
 fh=sYJfyN46Z0IrGku28hCCDJhxumBrnLvm6PyQ6TpnZDo=;
 b=QPpBs+sIf/hW+UWRzv3cFfQInjGMFginaMuH+x2ZPC9Hf44l7E8yy8E3d5WGA6Czrc
 eqQX3wM3S0gusfgRRBxEobjAwweppMayB77daEWV3c8WB3sNzNEco51mdEoJPaiffbIl
 mQfgpqVY1hFv8x/TsQexHyUStZGDs9bhKrorqhJyDdKCFzQH+d95xumyUjtw+j0UyWMd
 ZoX4GOWUSTMfWVwb9QNaUXMLBmAp4LcF27asNYdaG7YiTjpmEyKonW3rWkLuPLIAtJv5
 XAFhxQiqbX92mpKUJ/iGJWkHYxW0JHkPSuwe/xxp9FKcW4JslaOS1C2/pPGOPRBDe19k
 GRig==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1787582988; x=1788187788;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=07oNjsfBT41jW5cN1JTWMqNHCChA3JjpYE4IFdMvip4=;
 b=f4crgqN3WyFQf/woLG3wAi6XtbcIBamszR3CZDBJZzSdqvw1WOMWATHmNoi1itf4Iz
 4A2HEFf6TRHO1H61+tgWOw+MoJcgd21Hb8JUTZgQCU+IlKCOVhoFlFUt3Qo7IG82V4jH
 wv5PMqgBXnH/mGYCg+7idqKUEU3kCepHe88Ds3UEXKpb1FLNp15I6PBnHOryvI1HznaK
 QO/VJd7mBWkazUbxuwUd06aSmwDlgf/QLvuui0/gm1e9iNtkqEQVvycj2ktbQ50yuqzu
 vp/yfbDlFG7uztBlBdz1VVZOfJ6r6ZTJWy5cjJ7fzSq9ag0IOTlVjZEyfWxST3T4N68I
 0gjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787582988; x=1788187788;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=07oNjsfBT41jW5cN1JTWMqNHCChA3JjpYE4IFdMvip4=;
 b=aipxNYOjf62xDVjbhw+DL9UUCjD7kulEUV/e6emgyuf2yuF4MIaPswaGjw7NcmJoB9
 6gSHFbToL+O/HmfKhCNwlu2EcEBtmpTx1noKc/fRtDVWpxsj5v3gNCUgTebiAL56N6Z4
 LXwmfDaUuF+H72n802i8CVqSR7dEj0KicMmQ51oGOg+Zc7yDiwtXQdFxGyPiiWsMlVZN
 tQ+KkqJ/T6AJlNQ6TuY/e6FWjRTzTerUL1YoEzUwKpOYi9mUPMukw70sNmOcvLTpwJgM
 v0eZ00R0mZQffcRJVkLnWNWvnZKJ0sWkos6/RZNdsQufuOSstzNOmzToRRNwodenZ1f1
 lLhA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqX20QP/kk50Tsvo+4Zjdn/4igDien9K/+A7jhvMFnRJ5e5EY/1k5mXUtrioCpUThnRUq69Q1Q=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kVdyR+Y5ION0PyZDpc9Y/PN/w7rZpGhCkjMrBovTxOuIbCqwCp
 I0yZVdQOx0rPpUmNY7KHfw1QFRwtkMi3L+h76Dz9zZbxJrsq6ujpk4FoNJjwywz3uMRglF7Gznz
 yFO0qC4kKMOCPbi32yinHf7Yui0Au/YuiUl6xUvFQ7w==
X-Gm-Gg: AR+sD13owFcVqkZu8dmbsPaxsIL4pkmORXbBfVHgjqyuIh7nH/VXo4XQQhCr62+1yT9
 XiSbTZ3psIR3eVDoB91NKdNr09VGlTV4ts99a6HaTLHIzQLg0rANhXD57BCev5J1eCp2tdduXmc
 xNYe/ORMxcAYx31USt1sub8/d0Cq4p0mYwPUs/5X2lKTsm+Oh6Y2Gc+C1GyyAoS9KJUPrh14iYi
 2NM0Sc7K/LpCGjAqUMUFzi3SUrZw93BDZgsY++eI9CSH7iMXI6kwh6dBv1xMsSh740U+cI36vn5
 HmvWuWwe95uWZuWAWt0b0umEtlmPWxUAfTcvTffI0o+P60DeJGe9lh9GoZu4YewzYielOPE3ygf
 r
X-Received: by 2002:a05:690c:9989:b0:81e:c436:c530 with SMTP id
 00721157ae682-849f3dc401dmr111984447b3.14.1787582988317; Mon, 24 Aug 2026
 07:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260803-spi_fixes-v1-0-33f36e764104@oss.tenstorrent.com>
 <20260803-spi_fixes-v1-2-33f36e764104@oss.tenstorrent.com>
In-Reply-To: <20260803-spi_fixes-v1-2-33f36e764104@oss.tenstorrent.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Mon, 24 Aug 2026 09:49:35 -0500
X-Gm-Features: AcwNN1XR3THiIWzn2-nqItNU-HhqJpKpT9wFvA7eat7DEOTMoW_nXxTZz3gg7Qk
Message-ID: <CAEev2e8_B3EH0A0KuPK5L2b28GDJt6cyRZpuFAZeOM0o9t0bww@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: dw: Add supports_op function to reject
 unsupported transfer modes
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 u-boot@lists.u-boot-project.org
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Ssunk <ssunkkan@gmail.com>, 
 Jeffrey Yu <jeyu@issi.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Flaviu Nistor <flaviu.nistor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi all,

On Mon, Aug 3, 2026 at 2:01=E2=80=AFPM Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
>
> The designware spi driver doesn't support dual/quad/octal modes, but
> the driver still tries using these modes when it sees a capable flash
> chip in the devicetree. Add a supports_op function to this driver to
> prevent this from happening and force single lane operation.
>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> ---
>  drivers/spi/designware_spi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Gentle ping on this patch.  I was wondering if anyone has comments on this.
