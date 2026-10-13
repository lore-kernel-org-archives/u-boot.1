Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9D5CA9ED2
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 13:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 810BC605F4;
	Tue, 13 Oct 2026 13:00:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2oQTyvxdz3b7; Tue, 13 Oct 2026 13:00:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C98DA605FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791896400;
	b=r91jq3rgPwUCE6Y5HUPWaj4cZ8guA6cSpwSDHPFoS8tDd/O4QwTXNmMsszkzbSap8Zkk
	 JlIUmMtif3GEVMGbpOE3N9Zkl++kafUJHMheAd0JX5oCy9GE3j0HGjb0/UiF05ILY5CeA
	 b6YDi/JqpgZoJOVvJxOIYkc4f9vejjzchbduMY1BTcsgC5guX7Ksw+Q/hgTvF7UlRFUuD
	 S4wrfqGsURGoNNwS5Sdzr9pWvXwpbbwZjdrav5xfDt4NJLlLn4THgHDNHEvUZhtTBIVZY
	 /ZIl9FCg5ixofB1KqXuTzVvs3l026WCOtIjb88msxwomMW8IaSLMRctHK06Cz/O6VCQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791896400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iKtlockXOlLe0Z09OB99Eb3EQNjlVxtOuSaZFuvmG48=;
	b=rLQFswUphj3KakUQFX9ov3SGBNCZprDVQHwzUVoXG86V5oE2vqTpADedYC1cFKf3D3Dq
	 yTugY9L/H6PgyoDFC91zBiFtE+f1N7AR6pYdSAykxI0mGSXHT3HMAMvF6kBri6T1Y0ogp
	 9Gmwy2k8FP9A1Fqrhwf2yULEs4Qm/7WMk7pGkSnPTto/hGC2Xemt41kTFJC00UH4I2vYn
	 rhZOwYEY5m1eTA60tBwfoZPgGxzNllX83ykS12ZBS4K2pisGSImyz9yndpufwFcEu163R
	 1O/+sSSW3khTZSr8jbqEQY8IoEdOg1vDb+tA9bCBJTL3Cj7ZNxmjA3QdbmPWeyTWo+A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rxAx1lPW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791896399;
	bh=iKtlockXOlLe0Z09OB99Eb3EQNjlVxtOuSaZFuvmG48=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r3xss9UUs4nF0H92eYQIzutOmQyerZh0kIzgcRz9zu5PrzNFCCVCYUuHnIyyca+Wb
	 Fd6r26dtFkIy62rqjz+Fb4iOjrJTNqWvVt3tb/dJz//fSREAdt66M7TxR2EyvG/D4K
	 8tROWa9ZkecMEV6gSJl1AEVXQJ99pVuTFL9YjTWdPX+i0d4NmmuDExzHx2SyZxQ0EY
	 FpgREBDikhnX/D0mo+q2+GLScCxzW6bo79FA8SOJoeMU+YssNSS7B1ylaT/WeTvxRh
	 Gl0V3ngXfmGYhdVJuf70Adm1tTFkGmuMRvIcGQN1Tubt1mYtig8nsaHWQ27aKTjxEB
	 sbTsonw1zKb0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C98DA605FD;
	Tue, 13 Oct 2026 12:59:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C9571DE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:59:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E45C605FD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:59:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Ch_dtSotSHI for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 12:59:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A9B6A605F4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1130"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791896397;
 b=ANbL1aIjET46qRPtRO+ZuiyoXEtv/cxDtB+QH49qNydyYQFmJzRxEWhRdGguLLuNsU/b
 Ww9xVbGQIn6dNS4Eu8UdFqUE3YXaI/0Nf8YtH0o/c0018HD9pl7BD1Xomug9plFzVy/kB
 WR0vq6XoGcwrK86zYk5CMJjUcU8Un0AeJA4zGzL7UbEfzeEll8geQ0aN86ihpzQatg/i0
 eKqcHW/Kv/qtWmMPC7KCQL7WX9uMY4s4Xws5qX0Qqed8sD+Yc7CDrBGuYsM/oqwg1eJC9
 5urxOmfBTWMjne7YLWK+AJjTZry1SGYSK1RKVPiKF9I9AZQFmkTKFdMlNACCwA+zTxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791896397;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=iKtlockXOlLe0Z09OB99Eb3EQNjlVxtOuSaZFuvmG48=;
 b=U2HESX52qvYprWN82/le9UDJD6QiK9okogSAjNEB+PEG28FoUVMetYyKuVDAeg1sXlcd
 nS7XC2E2ceCmBH/lMO8WFC2m4AkWrQFQk2PV7EhDrRVuR8BdSZd5bndajpmk4QvAJzN0J
 GAvFIMdLiOpZyDutQoEu+X4M8UqvKIJru69jO+4dUoOLLaNNxG4tOuRQ2/PaWME8dIEpQ
 4b899VpZmwHRSi8o/Wu/OginszrYusLR4F4mrw8QhtUC863u/yPLb9h5KoF3BaWBZUQQ2
 joU531uqaQcqM3BOBa2kx6AAsvfAi+MKgQ9kPUxDADermb0SkKyxOGKXq/anRSpZ9ew==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rxAx1lPW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1130; helo=mail-yw1-x1130.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rxAx1lPW
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A9B6A605F4
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:59:57 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8ae8607e8afso19027377b3.3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791896396; cv=none;
 d=google.com; s=arc-20260327;
 b=S6Lig+a9G7BUf0G8f+j8V0n0DXkqX4SjB8cQwEX2w4Wt0ac4dF+rVEnjHAaa3suvHF
 Di2gUAlCyvVfDqYT4Y2nI96WbsHYKQLjUGxrkLzw1ISkBKVlYtuMABeOosOWpyms4+m8
 lP0lwzYGjp4fTz2SduvkcweimY1KOn+bIAUOmst8k0h79tPFrRRzQ7LPHx+9cJDR95ud
 P6ooWuB6ozzJt6RXTXRPfG1rRJkj+U4pD259GyxtQgKYukLJk0vN2Z471PL6lrbPnMZZ
 TSauVetUz3s9yJeryZ0NAbiUqOVB9o7FeDlfjQsmOP4VDGUCqDcMlK3EU49+JkB5APGB
 PYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iKtlockXOlLe0Z09OB99Eb3EQNjlVxtOuSaZFuvmG48=;
 fh=aCKbSDCstMDa7GsqFJmA5O6Vux3Y1S4osH2Z5BiwzU8=;
 b=GDudNMKwNL0ebQSLGvCQSzzcCiYwaQQml7pZ5BhKo0yylwHHyDtT06EK2DVothGbfg
 USC0ra97ABh5x1YK9DTA1cpEimpAWi/S/VHwRqdYN8FCZFa7Yp2MhAfoxq0GQ+3SxN7X
 yts7KAnjnBwdQjIcjWL19PBhwm0gmfAvnNNZ8DyWe6n8WIeJXoaDhpsN6n0VkQQULRjm
 A1EcjZtqgCAGoOmEvIrW/B/6RxPTaTJcCJmgeMUq2iH9fNg69uRZNGBAYamoBGKZ4Wz9
 VTZMIOip2eZkD8UMBGdDtIDxVm0r0xmJXSyEYleKkRxJbL38+nJbixy/rkcXHvm2ZBid
 6egg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791896396; x=1792501196;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iKtlockXOlLe0Z09OB99Eb3EQNjlVxtOuSaZFuvmG48=;
 b=rxAx1lPWj00BKDa48HVspsCz9SfIW5bhGDZ/drThcjQ5jDMbkKcO+NQ79EsAmzvcjV
 R+6dtX2vbNLriDe2WB0hXG+TgDpUwHJzABEqifYPgBVILc3VPIC2PqpZWrUm4fj1AtEv
 jzYh0/BDh8SC9yd+D0ZI4lFapvVgxWS+1W5WnUIjatoOcrj5iHaqlk114aTOBPLZbSxG
 ajRU3Dij0cuRyBlfS3JItHZuXck+/QsFg/GSj4v6KD1rkUsjD9WBrUCRhNabKUO6tfNA
 5puifUPgOXo7ssnliJkMx/MQYz6agMjMdxpOyQydc+0mgoT5OCS+9obYkE4D6JLlMcFv
 cbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791896396; x=1792501196;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iKtlockXOlLe0Z09OB99Eb3EQNjlVxtOuSaZFuvmG48=;
 b=2HkftWUqBKoGcKDPU5LS5+WuAjWKRj/R3YW+6YyiTUIHVCsVt+IbS8EkWBz4wbwPg0
 19biSfDiEZhAW1d8CecaROphMxGGmIYkrGGUBXQIgeI1ld9zvyDN2AUMQ8/MQJI2m42t
 qQtV1cjXbD1eGuJd1F8wV3Ur5kAlqBCFEeq+gcgrfTUEt1XTQFR8B6Mg2HCd0LzS1hP9
 Ga3UY3EIG/jZY7lIUlU4suCxAbavUCiYXt4di91Qnb8pYe/Lvpd2kHuswFOjginJKKfX
 y8CWjSW5YxQgPLU+eRMBs3f436tHnUNHQUaSDFEa+kRvpCkoxZLtUxVZg0B8lSPR7A4S
 Gh8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmfLlY1QVRbITegPPMrnmd2FGe3OkwEwS2Jzuy8CH06GVCm9gBcH1sKSaH3zcfmrGAmui7Oc0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLBW1HWj8rVLPhiC7j8Ov+7qPNzAVlN0Wy7neL/1Jdb5g+90rO4
 TfABm6hTflOw43qn+gmL3j20jdA1K9PE40vk75Y2EzUL8Oe/v4ohCeR0Nd5bzTXSDsZ6UZjG5w4
 kjBeIafjUW9UwL5xcgwTjYflwO7NWZPg=
X-Gm-Gg: AYBFou15aMdsmKc9cHtnC+yuyy/yCL6yREpqpS75A1t2NbMbUFpPMH9Z8PJiRsVwiHI
 8ppJxsC5prXZZwH+WsWzlC4ASn3dH0fTfNnTWY71Rml2h2vbDYbI/O2xIvJXGyl6s5+v+UMGRZs
 X8Xt9d1u7wkbCUnuP8usTe2avcJYTD4bqc8nebkprFj5tLd7ghCvGPsit39C6DlhwpPvPyLx8TF
 hO0/AkiMjzPnG09n9jrsywzxEFXdKz3WJSReoYtT3rWlgdPQKmqN6vOU9Jpy5csRWnIkV4N2/0B
 /LnJ4+2y7yPmYeod2/IoCjcb2/AYgPE+977v8+kFVks3H1hJKb2Nig29hNPr0TZBCC8w3jmn2My
 b29Dn5lcWbijghpEC
X-Received: by 2002:a05:690c:e3e8:b0:8b0:ad62:19c0 with SMTP id
 00721157ae682-8b0ad623055mr14279437b3.39.1791896396196; Tue, 13 Oct 2026
 05:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20261011070600.2788775-1-bin.meng@processmission.com>
 <CAFLszTgzeH9rEahc0uceFsFwMv1XDGUcj+0mCGPxHhc53wswVg@mail.gmail.com>
In-Reply-To: <CAFLszTgzeH9rEahc0uceFsFwMv1XDGUcj+0mCGPxHhc53wswVg@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 13 Oct 2026 20:59:46 +0800
X-Gm-Features: AclHuK_66yMbNCL9DuxZpeulDrwKf2vXBjoDG_nAs1d76qEm9xV-EFNBx0k7vXs
Message-ID: <CAEUhbmUEzK81jBL5XOHjuptyOhaMEE3FgB+BZfHMUZWAkm78tQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86: cpu: Use native_cpuid() in cpuid_ext()
To: Simon Glass <sjg@chromium.org>
Cc: bin.meng@processmission.com, 
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Tom Rini <trini@konsulko.com>
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

On Mon, Oct 12, 2026 at 10:03=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> On 2026-10-11T07:05:58, Bin Meng <bin.meng@processmission.com> wrote:
> > x86: cpu: Use native_cpuid() in cpuid_ext()
> >
> > cpuid_ext() saves and restores EBX with 32-bit moves, which clear the
> > upper half of RBX in long mode. The assembly does not declare RBX as
> > an output, so the compiler cannot account for this change.
> >
> > Initialize the leaf and subleaf in cpuid_result and use native_cpuid(),
> > which declares all four output registers and lets the compiler preserve
> > RBX correctly. Keep the structure-returning interface for callers.
> >
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> >
> > arch/x86/include/asm/cpu.h | 35 +++++++++++++++--------------------
> >  1 file changed, 15 insertions(+), 20 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>

applied to u-boot-x86, thanks!
