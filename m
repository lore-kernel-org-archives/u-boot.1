Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C14FC5AC82
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 07:29:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E76CA605D5;
	Mon, 10 Aug 2026 07:29:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B9XpjwM9U6RL; Mon, 10 Aug 2026 07:29:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 038DA60633
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786346965;
	bh=75AAxIY4/6gTrW6OcjJR4yr4n1b3neveGUBnMYq9QiA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F1VvTF1IT19pbNMkQsvO53a4Qc7MLqMvhB/kT8nQISffg71YiwVw/nfBXWmXrOpdR
	 x/NxLtcNjLHQdkDEq1XlRjf5VPVOH+leGM8EfJ4ggVTCc2YFA7q5Hm+VMS1ZD83n0T
	 AU1Iv7C1VNagc1dEKN9AWnL/hGw+AN3C4mFn+bEQXez5a1lRpwtBtF381pkd78zjtE
	 vG5xsO6kVcsOK8a60m1SGLZ8ddXipew6bx3upJvB2tyoVvRK6lI9zvpqdqYWd0ppEd
	 Nkke3o0lXhdUlMlhWRNWb19duuiHoZRxd9pfLOWVImAyKhj0OLHXbkISkApp+UygsE
	 j6Do4gVFKvdFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 038DA60633;
	Mon, 10 Aug 2026 07:29:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 78FE928A
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 07:29:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76F836063A
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 07:29:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id neHmm8xQp02C for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 07:29:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.81;
 helo=forward501a.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0FCAD605D5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0FCAD605D5
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net
 [178.154.239.81])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0FCAD605D5
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 07:29:19 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:59a2:0:640:b7cc:0])
 by forward501a.mail.yandex.net (postfix) with ESMTPS id 6DC8680E8C;
 Mon, 10 Aug 2026 10:29:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id ATHNhjne4mI0-EkeDlYa0; 
 Mon, 10 Aug 2026 10:29:11 +0300
X-Yandex-Fwd: 1
Message-ID: <3cbe18b3a3c30cf16b4b9fc5c5a1cc4bd273fb6f.camel@maquefel.me>
Subject: Re: [0/5] RISC-V SPL: fix OpenSBI FULL FIT loading
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
Date: Mon, 10 Aug 2026 10:29:29 +0300
In-Reply-To: <CAFLszThsggCcTCw63L71JhTCH2VC+HNUD=6XyBJNm9QpwLdmhg@mail.gmail.com>
References: <20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me>
 <CAFLszThsggCcTCw63L71JhTCH2VC+HNUD=6XyBJNm9QpwLdmhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maquefel.me; s=mail; 
 t=1786346952; bh=75AAxIY4/6gTrW6OcjJR4yr4n1b3neveGUBnMYq9QiA=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=LjDwQhyFadI0TlqyROrAcMiGDsIei+FCr3xHJXNU68gIxc56aNzm4kfKEM+WsLuPW
 3h++5XdC8w/z0AOPjUlrt3bARRw8ja/N1+CfDebB0dnnjLK9SDC/Pexa29Q8ghlM5L
 sIB+hG7zlI7P/L2tjOxk6fZejMfFbmIatEb5GIrU=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=maquefel.me
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=LjDwQhyF
X-Mailman-Original-Authentication-Results: mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Simon,

Everything noted and agreed for all patches and comments, will be
fixed.

Thank you for your professional and kind review.

On Sat, 2026-08-08 at 07:49 -0600, Simon Glass wrote:
> Hi Nikita,
>=20
> On 2026-08-07T08:06:41, Nikita Shubin <nikita.shubin@maquefel.me>
> wrote:
>=20
> > This series improves CONFIG_SPL_LOAD_FIT_FULL support on RISC-V,
> > primarily to enable loading OpenSBI as firmware and recording
> > loadable images (e.g., U-Boot) into the FDT passed to the next boot
> > stage. This aligns spl_load_fit_image() with the behaviour already
> > present in spl_load_simple_fit().
>=20
> Just to check, what is the motivation for using LOAD_FIT_FULL here
> rather than the simple path? spl_load_simple_fit() already loads
> OpenSBI as firmware and records loadables, and is what existing RISC-
> V
> boards use today. Please can you explain in the cover letter why the
> full path is needed for your use case (e.g. full FIT verification),
> to
> justify the extra code in each board's SPL?
>=20
> > - This works only if FIT Image contains dtb blob,
> > spl_load_simple_fit() on the other hand relocates gd->fdt_blob to
> > the end of U-Boot;
> > =C2=A0 It's currently unclear to me if spl_load_fit_image() should do
> > the same.
>=20
> I suspect it should, since boards ought not to see different
> behaviour
> depending on which path is enabled. That can be a follow-on series,
> but please can you mention the limitation in the commit message so it
> is not forgotten?
>=20
> > - I am not sure if sandbox test is a right thing to do, still i
> > think it's better than relying on QEMU for testing in this case;
>=20
> Yes, a sandbox test is the right approach - the spl_load tests exist
> for exactly this purpose and run in CI on every commit, so please
> keep
> it. Since the test constructs its own FIT at runtime, the grafted
> image you used for manual testing is not needed for CI, which seems
> fine to me.
>=20
> Regards,
> Simon

Yours, Shubin.
