Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A25FC624D0
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 12:30:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65FAE6086A;
	Wed,  2 Sep 2026 12:30:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E2S81i8BOa0v; Wed,  2 Sep 2026 12:30:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788352205;
	bh=h74NdKXUuK7sImqsxu4kOTlsWg+ii7IEosPgSPdUXgc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x0pv0n6qpsR6OMBsb/N2y2TuLyfZ+ichiIiypwgb4r86ADKOaACD2LIIkDmn6Oihd
	 wETNkmKFC4NPmRYzmeHfOMUjWg1vK9jom3RMwFWR+2UUSunpEBVu/3mmLJuvTxTf9o
	 /LH695iOsGN7I3lRJX1aQQcoaEjukgPRAcrVEWqCSXW3Ka3zwaiFEfuR6Fv2/LxMjy
	 haTuctrTInbARS/6yN4GQKlVK1Zz9rItuWpXWAbBMVNDa0nuxnHD+AjwcTbiSaw4bx
	 8yNGhJgUJYlAwHH/U4PhvVgcREohmw++tlFZMH5z7t9Y11BHuNWYTQKKI3akQmhj6P
	 +768vwmp52smg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B38EF60703;
	Wed,  2 Sep 2026 12:30:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CA7AD230
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:30:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC28180E48
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:30:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KHRSlV7hZfEx for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 12:30:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=gLs3RCK2
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ADCB080F2F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:30:03 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so101244966b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 05:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788352201; cv=none;
 d=google.com; s=arc-20260327;
 b=Xyx7mecBvEH6j3CO5Vm2IdipGRuLOyiAXvtLp5pKju80h4aaA85qDVdZpISViMVTlv
 66V1uKHssIn4eX/zkNbkPB82qyyKTHWkIC7P6hy2i/ilk5PllCt0rkFLDv3e0I/9o30l
 O+zHK30yfzcs7AAEiBCu/tVeTMsQKf/5ZvFFSZgZRy3eaEvNYIkH4L1nwT26/pNd6atQ
 3BnP8eMHc+qbS2mKJ9/6kKERlWMCra6Z/yr76j821ef/K7LyL3+V0Lf3CYeosuYKg0W3
 /88V45nZCAtY0M1qVK1C8tGuRbplGOZd/rqWMnf8RLvJ3sbWzCJRf6I8qbm72VNpkNUW
 6V/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h74NdKXUuK7sImqsxu4kOTlsWg+ii7IEosPgSPdUXgc=;
 fh=ml8DNRS8aqO4Vlj6SsKZJ0SYYtToVlYtqKduOOYSkug=;
 b=abqsVEhiUb+BbUU+j9VQrQVvmUStJwg5Ge+05/aA3kL2z4h71Zxz1nCFzYyV4d5cnx
 MDfPW6J9ynExdFJNiXWOejAhNmnrrmFJ6Vst0+BFfv3H2u0mx2ciWlLVN/W+/ZgD4/Z3
 BDQjdOgXCYp3Dk7CMRa5HgWFDhKJSDBqhScOHed6oA028TuwkP5wY6Rdop3/xBhrRwKK
 Emw7dRDhsqqY1HGHbPxfqRBQK+kjyYHOiTMvX/pOjTzVoM67vpwrhkj41aVqt5MpKAH6
 7GOuU9BVJ4+oWRZ0GPvAdEJOHl40d3/U18cP4oHV3YgpgUPxk0ijGeHFUdalBmZP4Zvo
 yrbA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788352201; x=1788957001;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h74NdKXUuK7sImqsxu4kOTlsWg+ii7IEosPgSPdUXgc=;
 b=gLs3RCK2PmhOUJ75mhfi+nK5Vq8Mxxr9as5lc1j1zwHYpRJbvZdAvoDHMo9py/wtDj
 a280SYSnl46Yk2P+X9sEyGKtIaGMLZZQK90d0goVYCVZ+Q9y2AqpT/D12ATOfLG6RDYA
 BwVos8kMRHIDC/Mj5ied+FLDCiroCx+ufN9+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788352201; x=1788957001;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h74NdKXUuK7sImqsxu4kOTlsWg+ii7IEosPgSPdUXgc=;
 b=oNXXINrxSFdDIPJ8DJipatGCNuWXhBvXgsNWx/ZnoWmBkuAlWtgPawMmYlGIwG+s1U
 ymzBWk24EW2qKgyr8aME2ROwSvdHUU04z4Qx1FG6iKntnnRXxrk++VCqil1cfSAlUcWU
 Rj/ofJqxQzfiBU44oHOiwldC16ubsyriStxYlKG7DWhE+q/z0dovCrcXP5W85gfLBwoH
 wg8962MI2spn4f/dWZntOUoFNmCH062WmMHSxfM41E24tTidM6kbKWcZddTaADWziRhQ
 1PiBO1ABI8kqbWsHIsMDB21CC/XSuAI7Bwp+KGCfaFyDBiLJQ3sX2bsP3WuD7UTPoawR
 tWFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxinCOPQ207yvRxvfUNdAEM3OrOTmTNs83e8gQ5UuONAIqo/DPXqpW+s4snrXbL2giBfW19rF0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l4Oa9B3fVUSdi3k96iQvgN61yiKL4yjPOHB1WulJ7BDJwf7TIg
 v9J6utD3BhksQG4cBoqKzr2bTlEXHDd/+mbwmogUhJNlqsE+b6oR3DWBmgAylkesr1HhfsVOFMI
 Yyp+BaokiyLrQofy/BSxRWlYOOu7lTy3hs8W3enopgCu0A+A2ZHzI+M+Y
X-Gm-Gg: AYBFou1osMpSyzNKptI/N+LY6t/jbCx9KPBn6kGnsf3Bke9WXXSJTmSn/vRsOjE0B+H
 bueeXWZD0THQfHvK+7uN3/EE/g/8umn3Y55HOQBbdOJej4HyBhcakaXkfJMAq8vbJwTUXpBWnSi
 FAOL19d1ZinGU3c+O5UGRWkGHFXdUbBAEn57M33qWaZdlubvgHvmB8mD67OfD667buWA4SYnKSB
 O7lD+XDxAUADU6VGjWuRgKLvGv30Xkbv7knl5N5uKQg2ljNXeDrztYBkjcGINPPOFt8elj8O9lN
 uAzweXNGEWevdUUMiE7pPhmYClNorJp4649t0lA+Tws=
X-Received: by 2002:a17:906:c150:b0:c25:afb6:2d91 with SMTP id
 a640c23a62f3a-c25d527a4a2mr276798866b.2.1788352201079; Wed, 02 Sep 2026
 05:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <nsbob67calfo3hn6y23psz2ornx7clha4pvozyify7a2sicqve@gchdniswepfp>
 <CAFLszTi+xSGKG7pmjJ+z0KKRPRXht9h81AUx9tX10SwvhNS=gQ@mail.gmail.com>
 <20260901140325.GD1145425@bill-the-cat>
In-Reply-To: <20260901140325.GD1145425@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Sep 2026 06:29:48 -0600
X-Gm-Features: AcwNN1WXK1rg5n5XhQZXrksG9oc6wWN0y4cTOUBDYvLlEo5C-erwMxsIjy67yKQ
Message-ID: <CAFLszTi62jXxPw0zecRUu1jdGt5L1gM3SRtiLsov5TDvT2wtOw@mail.gmail.com>
Subject: Re: [PATCH] bootstage: fix unchecked malloc and undersized buffer in
 bootstage_mark_code()
To: Tom Rini <trini@konsulko.com>
Cc: naveen.osdev@gmail.com, u-boot@lists.u-boot-project.org
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

Hi Tom,

On Tue, 1 Sept 2026 at 08:03, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Sep 01, 2026 at 07:47:36AM -0600, Simon Glass wrote:
> > Hi Naveen,
> >
> > On 2026-09-01T10:23:25, Naveen Kumar Chaudhary <naveen.osdev@gmail.com> wrote:
> > > bootstage: fix unchecked malloc and undersized buffer in bootstage_mark_code()
> > >
> > > bootstage_mark_code() allocated the label buffer without checking the
> > > result and then dereferenced it, risking a NULL pointer crash on
> > > allocation failure. The length calculation also failed to account for
> > > the "," and ": " separators emitted by the snprintf() calls, so the
> > > assembled string could be silently truncated. Additionally, when file
> > > and func are NULL and linenum is -1, the buffer was passed on
> > > uninitialized.
> >
> > Please rewrite in present tense per U-Boot / Linux convention, e.g.
> > 'allocates the label buffer without checking the result', 'fails to
> > account for', 'is passed on uninitialised'. This patch aims to change
> > the current code.
>
> Hi Simon,
>
> As I said the other day, please stop telling people to rewrite their
> commit messages when it's already clear and understandable. This simply
> leads to confusion and frustration among our contributors.

Then do we need to change this?

https://docs.u-boot-project.org/en/latest/develop/sending_patches.html#commit-message-conventions

Also, we could perhaps introduce an AGENTS.md file, so at least the AI
assistants follow the guidelines?

Regards,
Simon
