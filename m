Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B072ACCA46C
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 22:02:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F33340B09;
	Fri, 16 Oct 2026 22:02:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K00FhHRadI6x; Fri, 16 Oct 2026 22:02:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B54E540C1D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792188143;
	b=LYRaFARYfw3/9HlybBbtoYXsc0Tj+YEjAu/W5MyKECcTebudBHazg427DXNH/XGIWTMN
	 sA2O3QA8sdaYj0qR3zhIsJAsUZeK3ZCjvQKlGiYsvAY96PEoaqSlR4FtM8EbEWQQIjaUd
	 YwqVZtQ0DkWsuE2KfeHu5s1MmiOmoSbxK1U211GooocpZ3eACuW2p/MSagdem3sqpsJfK
	 ehhy67KJZMX6E+WZKgykpWYfEmGRHhilpds4H8pBmFaH63gfD5fdx1udRg7XMfgXNx19T
	 evpDi8cPXdkdU80lQiI/k3YBZfJW5AwbqITvoqC+Qbd+0T3mnJzHBxZkOuphNrII/6Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792188143;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:from:In-Reply-To:References:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=46RbolVTO07PM8A0uX5jJ7di5f3dl3VTkCh5V2sZUu4=;
	b=STldK6BL+BBrc2AuHpAB2dzaUoczS4KQoakOwvf8zL8PNNzg4SdmxOOk/Ks6ne1hy51j
	 HRrjDmFzgLG7QyFbgzcsVz/zrfomr6I/LlqvUeG1bq85VKpAZsJxM7vfp3YnagQwXfqjH
	 oBSdypIw+a6JEgF8FeE6XoOZOsFfMAliZDWsNZO3HjcYwqLa9pZQmql5jQDXvBLUM2G81
	 tQ/qOps2jiu12CJLZgaKqq/yz+cpztfnVygzOuU0FVAna5+mAce1qwqFXyRIiZgYr1zgO
	 Y+2AG3pNLKtt5UlfPqDnvxyitjiMqO32YBEMAeQOYX1ORe4K3JuSzHoYM1pYuSolIqQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792188143;
	bh=46RbolVTO07PM8A0uX5jJ7di5f3dl3VTkCh5V2sZUu4=;
	h=from:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H3OW/ugkk3eYFSHI0+5whbCRm/+Lf26rWueWYvJaCRazlK1550darp5o5nHiLvvV0
	 JDZ/RKw1IOkT9vrbNIRANVAGVJ1ePOpFTwvmTsEZRS4+DVucvBJEvXbW83DrNSL0LG
	 dmWNipgP121dwycQm5CyjmhE0RfLhfXJZPX+zGhrHOutRdWdsDlnwdx1CAlqYiMW0Y
	 Bxrb0iLfI9molZ3nrSMBCsUGqVQkJ4KikJTg3fIwLGehch3zQU19rOzcSQJrxA1HCG
	 Q1FG796jcdCHMCai79khgL7FY0FgtTp6POM32SDNa/d7XVZHoi1LVrmIlJgLwLX2Ug
	 tMBWnDxA0wlHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B54E540C1D;
	Fri, 16 Oct 2026 22:02:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4352D1DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 22:02:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 34E71409BB
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 22:02:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TwYeRJC5-9jr for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 22:02:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2A8B0408BD
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::631"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792188141;
 b=b0iOn7rPDTcQf4/1l9R2BIJRon8KAKaZC4xh7bVtKbjd+DK8uy9bqG216WaZ9EUI5gyO
 WEeAQTtECdnTbkPwD5xioZ6WgLQak1eiw2Kj5mKtO62XtttjzyWM2OV9zez1zw5Ql5otK
 eYu/I4z84sIzLnsSlQfk+fSNO4ebpLF0pr5GOgVupQ3rBV78tDlzCygIhbWIBDSg/rR4+
 GfxK12WhICAStzxwNbugn9rkRD3ByNVg/U407cFd1UEKXp4vJkmTkB+RkRLRhujOUtkaa
 jWHjAfoABS1pJ0NLYk/B3nUsx6JtzfIKf+m7QOlj97YIcachVspwX623JwQICbduLjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792188141;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 from:In-Reply-To:References:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=46RbolVTO07PM8A0uX5jJ7di5f3dl3VTkCh5V2sZUu4=;
 b=RSfsU1VwktOk7D1mHGWxiK+FdaKc8aNQXmJ9ojTA6Ctb2oIhlQnN+XnbB04MB/Y4gBNq
 mnxJIF481q9G6YKrT84wA4W0x4pGg3or84RfRVDeCp59D+yeaUaAzHAKWo8L9JtScxy6n
 xSodsxJCnxbzUVFQ7D2IVp49jhb5eX2IowSgeefKTybEbPX7bOV6vX00yLcCzBy/F8gGr
 b0I1ylRJ14kyqPeCkU7BhIrTGccS+3LLAlccPR0cCOI+Yd7GEcGtELVFfkcbCj25tDrLl
 mgok8dsLrL76otUDR3dTq1WtxmqBfkDtzRZkhP/2Q1Jorvb+7GcyLuYR5yQG9M5xxmA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DamEfP7E; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::631"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DamEfP7E
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A8B0408BD
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 22:02:20 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so264597166b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 15:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792188139; cv=none;
 d=google.com; s=arc-20260327;
 b=B0lQtLUqW+stVBmoK4xIbbEsgYI/zkFZ8XTD8d8sNQ6YodCkIVJUWFd+Lshbde34bT
 GJew1XRGCwM7Ymo9WUR2qDbUoz6vIpgTQmUe+23sM78Zz2zYG2Vy2AFYqzFfstqU8ARy
 Pg/TW4WCGnwXwX/R8ppYN6vpx+QnFkGmCE+KBbhljDFnZs4TEC3acAGXhU5GymHJMBai
 Bp8eUHzj32jDiTeL1EBnOErLM5kZC1JECPSmb5Jmo0ciQusbPpZF37lVkhFOefB+pt8I
 HvXMP5LEoWPR3SHCKMdyowGJRnAyRZLSupObvFuG4JNWwoBP3Y6W2Xl3V9UBwropK8pB
 eGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:dkim-signature;
 bh=46RbolVTO07PM8A0uX5jJ7di5f3dl3VTkCh5V2sZUu4=;
 fh=QUW4UFamh8lGjyLmF2r7pvpyaBwGVLcJ1lVGIlypT/c=;
 b=Z5JY4PdzGcHW3xWeQYTHdOpvJMV/3bjboNSNDSmSF/OXMROW9i/0w21+lcL3jK9C/J
 JEcA0EoeROFLFnJT6sv9jPh8m3y74fOifR3ob8bh5kXH5y5CYs5rsnDMzVdGjMbu2U0F
 t5kO/wA+3B9Lmc6usKI1r8VqF9C3fM5lAMmI31uEhbER36dH4N/j/wdyVSTfH7idCvIP
 oKtm2tG1q2WZL+L7PXh3JLHcCsuaFb+8/zZSTemg4Jta1G+1bHEm1Es8B1U8kLyhHeZE
 Q+3CxIBtgx9oTERsIqBby7QG1xAdK3EW3HpzM+R3KaB4iEv+a7kJY8nSMv8iPvlTQ+Nc
 DIaQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792188139; x=1792792939;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=46RbolVTO07PM8A0uX5jJ7di5f3dl3VTkCh5V2sZUu4=;
 b=DamEfP7EG6HL8tNEn4TwthOOwYe/Z2XN6NRaTlubQN0GcAY6LSZi+/PKI7ieF+2Nc4
 vEkpcgmHowGl094K5CKbsOuLyJLhw5THh4m+Z3TcIRdKMHGAVXJxGQekzwCnyN9TOFCT
 owg3cfCozsGv12SlEOCK1WXg7btjg66KD1SSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792188139; x=1792792939;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=46RbolVTO07PM8A0uX5jJ7di5f3dl3VTkCh5V2sZUu4=;
 b=043pyxbHmgzhBF1TNoxqc582/qABdoLfSwOE49Oa+2c+o4RvUuLtmWzKLEOH4cgOT4
 J0H8fDhEnnMKzmY/R1lYSgWhO2hA6+JA06u++hQnlD/ug01V6hDHIcwZydT2IM6Y4KsJ
 daoMeUPEYWbktKLF1g9MdvJqrG5cc+YjENKeFiKBT0/YzzyauI3bSIBdUeRKtLHdG11Q
 YHX5sB2k17d+wvdouztBearvcjQ2KVI/N3KR8ElyN7mx8t5wm3M0QE9WhdUTH6WBEZeP
 VcRtN9Fp4fDs15oJZRAI/WD252QBayEC/blxKOT+em5zuu3pYkPJGORz6JmhGOFRFbiI
 95BA==
X-Gm-Message-State: AFq9FYL37WYDJxpc0rrYOxSa3/Z+LV8LKJsZ+c7R5AULPzy4ePo5rsoG
 3t8VDgpFpOF63xgtA+sSJ55x+fsJSEPkj6aRXWAiU5KLiFcZVkA6qThKgCbKJdqjEp9MqyTuPr7
 vxtgWV8CG6ZviHdgv+sFroYB+Uvh9gvqK6fR6yl07LBPCQETmKj3eHA==
X-Gm-Gg: AYBFou1oUmwEWef/ITpqqcGRxe0FE1XTJWB4JhVMOTRdCIwQ/2HgbHnoJH2y7MwhKT9
 Nuj3S6Qdnv3l+PWmdrP4ZT+x3zdZKiquSB+nGe8ud58coEUWDhp8fVbcxhC9sUZxgbl53n/N3Jb
 SbA8daRM/7zaxrk2FMwjszEnltSeinYaxYxAo5EL2buHwtN2lEyWGiZXcNfY2KZuY3DZ0hnNOgK
 zBhXZp+dC1la1pKktYL2N+IAzqPski3RbUEw6tqJW6nQ/GjKnDBmP2WNAydvi7Xy5tE+KKFGRlB
 z1sBORNugjMRJgllgIEtTw4iRrsu/9q3ueNl673f+/cvxqEs4L+AWA==
X-Received: by 2002:a17:907:930c:b0:c2d:c060:160 with SMTP id
 a640c23a62f3a-c40223d9d7dmr401937566b.25.1792188138657; Fri, 16 Oct 2026
 15:02:18 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 17:02:17 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 17:02:16 -0500
MIME-Version: 1.0
from: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAEev2e-CYqKF75DtQj6A9qXpTGxSyJJUbLRieyxaX6YDWOaf7A@mail.gmail.com>
References: <20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com>
 <20261003-aspeed_vbios_fixes-v2-5-f8e593f024ab@oss.tenstorrent.com>
 <CAFLszTg=sjS0hHdh9peMk-bzbHssVpMFPDyTu694-nf3W7p8HQ@mail.gmail.com>
 <CAEev2e-CYqKF75DtQj6A9qXpTGxSyJJUbLRieyxaX6YDWOaf7A@mail.gmail.com>
Date: Fri, 16 Oct 2026 17:02:17 -0500
X-Gm-Features: AclHuK-6zbs5nAETWJwfi_rsxif8RKb77DYAnyBCGc1HGNoHMwfTvcNrXJXJYzY
Message-ID: <CAFLszThAHMM_RjT_mW+3cG0oHfyO88+KOGeynOoJJ+H=DRN5Ug@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] bios_emulator: extend VGA I/O ports to include
 ports 0x3B4-0x3DA
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Anirudh,

On , Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com> wrote:

> Let me propose a different solution here: What if I just drop this and
> the previous commit (support 16-bit reads on VGA port)?

>
> If I implement custom ops in the Aspeed VGA driver for all
> BE_(in|out)(b|w|l) calls, then I don't need to touch this function at
> all. All the port/range checking needed can be handled in these ops
> that biosemu will call. The existing biosemu code will just look for
> the custom ops in the driver and fallback to the existing generic
> version.

Either approach is fine with me. One thing to bear in mind: ports
0x3B4/0x3B5/0x3BA and 16-bit CRTC accesses are not Aspeed-specific,
they are standard VGA behaviour that any VBIOS may rely on, so fixing
them in the generic emulator benefits every future user. If you prefer
the ops route, please add the hook mechanism itself as a generic
biosemu feature (not Aspeed-only) and keep only the truly
board-specific quirks in the driver. Otherwise the next VBIOS we meet
will hit the same gap.

I'm ok with whichever you choose, as long as the generic path still
works for non-Aspeed callers.

Regards,
Simon
