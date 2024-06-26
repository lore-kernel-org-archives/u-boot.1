Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C2CC30653
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 08:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E3EB88149;
	Wed, 26 Jun 2024 10:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719389448;
	bh=z7nSPaCIEwMDXFQDdCw/MMNVshQlfBbtGeePxIk47gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z+NyjdBwj6Tw3DAxF7QiRjcOj3M/g6x1H88K+VtxgJWoHvc3ax8pCYLtHjUkRQIRw
	 x0g1eqVe0tAmvxF166UzxJt8dgin6odZ4mZCwiFsX+lMIovJCEX1V9idjjkvSkeYde
	 8Lb0QOzxAo/S30KewR5CD7SJTvW1xCr/BC3Ayv78hnqE0TeGapC6s03q9QMlTo11J6
	 6VABcQ/j60AFewe3HsrsDbbkT5IFo0vdYzOjvZPXowsxIxVEskXLfSHuJW3/9bwWvw
	 vNsDMKLnKpHbowzsjMej4Hnme12MA5Yj/pJQngErQ/DxytbUltm2M2G91qDA62uPhl
	 ik82Xl4jNh9bQ==
Received: from eryximachos (unknown
 [IPv6:2001:861:52:5f60:ff6c:4545:dfcf:4c97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8A269884C3;
 Wed, 26 Jun 2024 10:10:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719389446;
 bh=z7nSPaCIEwMDXFQDdCw/MMNVshQlfBbtGeePxIk47gI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=blMmxstOcQ1JnHnavL3HZym6QzY+FpqdNevCUzOQ31FLdNhydlG2yf2Mf99kpmkUY
 yPVQJF/9reGh5EjZc6A0pt7GT4ZUFgwyVhlyrAklt44K13NkYHw1+vBumP4NnNyAni
 8GWS25nt12zobs2P7f/J79FtEhu40nIMMH9GrESRgHFA47ELO60kjKOZR1e9p0K9Kb
 oV4PhVfdw1wYzR7KNwqy4X36invvXSjb/YFCJ9Qr+4hkFuWb0EcI8zRsGspYWf6JkM
 bGp8hHKL0psOKPfmIiPtg95VCcw25GCeGBUp2PDx1orXOfw0eoPsJahFAcSKko2Hw7
 fNOh8l2NWG+/A==
Date: Wed, 26 Jun 2024 10:10:44 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, bmeng.cn@gmail.com, caleb.connolly@linaro.org,
 christophe.roullier@foss.st.com, epsi@gmx.de,
 eugen.hristev@collabora.com, festevam@gmail.com,
 forbidden405@outlook.com, ivprusov@salutedevices.com,
 joe.hershberger@ni.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 leyfoon.tan@starfivetech.com, marek.vasut+renesas@mailbox.org,
 marjolaine.amate@odyssee-systemes.fr, neil.armstrong@linaro.org,
 n-francis@ti.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, philipp.tomsich@vrull.eu,
 rfried.dev@gmail.com, seanga2@gmail.com,
 sebastian.reichel@collabora.com, sebastien.szymanski@armadeus.com,
 sumit.garg@linaro.org, trini@konsulko.com, xypron.glpk@gmx.de
Subject: Re: [RESEND PATCH v2 1/5] x86: provide mb() macro
Message-ID: <ZnvNBE_NEK3IezFL@eryximachos>
References: <20240624083450.90297-1-pro@denx.de>
 <20240624083450.90297-2-pro@denx.de>
 <CAFLszThMCOvbKdRTUJ_kk_uj31dwnuwgjK6AZwuLrm0_aZOEYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLszThMCOvbKdRTUJ_kk_uj31dwnuwgjK6AZwuLrm0_aZOEYw@mail.gmail.com>
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

Hi Simon,

On Tue, Jun 25, 2024 at 01:30:18PM +0100, Simon Glass wrote:
> Hi Philip,
> 
> On Mon, 24 Jun 2024 at 02:35, Philip Oberfichtner <pro@denx.de> wrote:
> >
> > Implement memory barrier using mfence. Linux does it equivalently [1].
> >
> > "The MFENCE instruction establishes a memory fence for both loads and
> > stores" [2].
> >
> > [1] linux/arch/x86/include/asm/barrier.h
> > [2] Intel® 64 and IA-32 Architectures Software Developer’s Manual
> >
> > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > ---
> >  arch/x86/include/asm/io.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> > index 5efb2e1b21..936ad6f588 100644
> > --- a/arch/x86/include/asm/io.h
> > +++ b/arch/x86/include/asm/io.h
> > @@ -244,6 +244,7 @@ static inline void sync(void)
> >   * have some advantages to use them instead of the simple one here.
> >   */
> >  #define dmb()          __asm__ __volatile__ ("" : : : "memory")
> > +#define mb()           __asm__ __volatile__ ("mfence" : : : "memory")
> >  #define __iormb()      dmb()
> >  #define __iowmb()      dmb()
> >
> > --
> 
> This exists in arch/x86/include/asm/cpu.h so can you please remove
> that one as well, in this patch?

Thanks for the hint. I'll include it in V3.

(Assuming I got you correctly, to remove mfence() occurrences and
replace them with the new mb() macro).

Best regards,
Philip


> 
> Regards,
> Simon
> 
> > 2.39.2
> >

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-22  Fax: +49-8142-66989-80   Email: pro@denx.de
=====================================================================
