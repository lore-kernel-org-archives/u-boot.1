Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62F5C28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 07:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC57781F59;
	Wed,  2 Apr 2025 09:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tLavq0+5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E028080584; Wed,  2 Apr 2025 09:13:08 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9B7C81F66
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 09:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 839F25C3A71;
 Wed,  2 Apr 2025 07:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7EDC4CEE5;
 Wed,  2 Apr 2025 07:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743577981;
 bh=nK6TmYBsb7ckC72nCrFXSYxjvsKRoXt5OHyuYLOQlts=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tLavq0+5beQWr5t2i5MdoJ/mwQntjWdrZxI6sbPrukvyhsa3+luyCs4pg7huGzLNu
 P1ByEIubV9BNHggDYQLoVB4tqUrR1GyW6HzTg4ArxtvrMy4ol/YIVKcYt21J//l/7a
 DEqtAEYWaxOhagSnGHIahuSKCZoIZCG6FGmNEdpwSlZFuBvqFGFoo5t2T/GyEjBgkZ
 c1LcQyGRyvo4Pqz2WpcWuUvjQa+JRv3C1z0dw5WWNqUb2iL1Njdv5rBOqWBhc54WQJ
 ie2rL4fGfoBlk6LoC/IxcNCa37nCyN0nnnB9U7upd9vcuK/oq+E+qQAo7nR2cYv0/R
 6xuNP8UA7EKcg==
Date: Wed, 2 Apr 2025 12:42:54 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 5/6] dt-bindings: clock: drop NUM_CLOCKS define for
 EN7581
Message-ID: <Z-zjdhegA-W23qc9@sumit-X1>
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
 <20250314185941.27834-6-ansuelsmth@gmail.com>
 <7923a39a-184c-4774-ad94-4d72563c8b60@linaro.org>
 <67e5659b.df0a0220.19a25c.f830@mx.google.com>
 <37c1455f-8d53-4643-b57e-3a888e5dd23d@linaro.org>
 <20250401144420.GE5495@bill-the-cat>
 <7b6542f2-0a2b-48ce-aaac-0bdf2f9b2fca@linaro.org>
 <20250401164016.GF5495@bill-the-cat>
 <62fd6270-e6df-472d-b3ee-0023bfce8d27@linaro.org>
 <20250401180217.GO5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401180217.GO5495@bill-the-cat>
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

Sorry for jumping in late in this thread as it is still using my old
Linaro email ID which should be disabled by now.

On Tue, Apr 01, 2025 at 12:02:17PM -0600, Tom Rini wrote:
> On Tue, Apr 01, 2025 at 07:28:36PM +0200, Krzysztof Kozlowski wrote:
> > On 01/04/2025 18:40, Tom Rini wrote:
> > > On Tue, Apr 01, 2025 at 05:27:30PM +0200, Krzysztof Kozlowski wrote:
> > >> On 01/04/2025 16:44, Tom Rini wrote:
> > >>> On Thu, Mar 27, 2025 at 03:58:52PM +0100, Krzysztof Kozlowski wrote:
> > >>>> On 27/03/2025 15:50, Christian Marangi wrote:
> > >>>>> On Thu, Mar 27, 2025 at 03:43:47PM +0100, Krzysztof Kozlowski wrote:
> > >>>>>> On 14/03/2025 19:59, Christian Marangi wrote:
> > >>>>>>> Drop NUM_CLOCKS define for EN7581 dts/upstream/src/include. This is not a binding and
> > >>>>>>> should not be placed here. Value is derived internally in the user
> > >>>>>>> driver.
> > >>>>>>>
> > >>>>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > >>>>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > >>>>>> Please drop my Ack. I have never acked such patch for uboot. If I did,
> > >>>>>> it was by mistake - probably you CC-ed me for some reason.
> > >>>>>>
> > >>>>>
> > >>>>> Some explaination, uboot introduced the concept of upstream where they
> > >>>>> "import" linux patch for dts and dt-bindings.
> > >>>>
> > >>>> I expected OF_UPSTREAM to be taking the sources, not patches.
> > >>>>
> > >>>>>
> > >>>>> This and the other patch are the exact upstream patch with only the path
> > >>>>> changed so I keep all the patch commit message with tags and added the
> > >>>>>
> > >>>>> [ upstream commit ] thing.
> > >>>>>
> > >>>>> Hope Tom can better suggest how this should be done. You were CC
> > >>>>> probably because the git send-email included you as present in the
> > >>>>> different tags.
> > >>>>
> > >>>> Well, Ack is still not valid because I did not Ack exactly that change.
> > >>>> It does not matter for the ack, but for Reviewed-by it would matter,
> > >>>> because it is a statement (of oversight...). I cannot control what you
> > >>>> put into patches taken out of kernel, but at least do not Cc me on that.
> > >>>
> > >>> In specifics, yes, we should update doc/develop/devicetree/control.rst
> > >>> and maybe doc/develop/sending_patches.rst to use --suppress-cc=all for
> > >>> dts/upstream.
> > >>>
> > >>> But in general, what do you expect people to be doing with content from
> > >>> devicetree-rebasing? We're doing some direct cherry-picks in between
> > >>> merging of the tags. I think it would be weird to be dropping the tags
> > >>> and un-attributing peoples work.
> > >>
> > >>
> > >> I rather expected something like how kernel is importing dtc. You just
> > >> list the commits you get. If you want the full git history, then I would
> > >> expect simple git submodule. In both cases there will be no such patches
> > >> on the lists.
> > >>
> > >> For the Ack it does not matter, but I would feel uncomfortable if people
> > >> were sending stripped and modified patches with my Rb tag.
> > > 
> > > I guess I'm confused. Looking at
> > > https://patchwork.ozlabs.org/project/uboot/patch/20250314185941.27834-6-ansuelsmth@gmail.com/
> > > we're doing the normal thing of havig "[ upstream commit <sha>]" after
> > > the imported log. When I merge the subtree and tag it indeed gives what
> > > you're expecting too.
> > 
> > When you merge subtree, the patch is not modified and it lives in
> > separate repo. No one sends them over lists, no one modifies them.
> > Unlike here (even if modification did not happen, person was touching it
> > so how can anyone be sure? That's not a scripted process).
> 
> We merge the subtree on tags, and people cherry-pick commits in between
> tags when needed. This is a case of the latter, which is why it says "[
> upstream commit <sha> ]" in the commit message, which is the usual case.

Although we have tooling to pick patches from devicetree-rebasing tree
but I can see Krzysztof's concerns here. We can't be sure if developer
has touched the cherry picked patch or not but I suppose there would be
similar concerns for the stable backports for Linux too. So IMHO, it's
really upto maintainer applying those cherry-picked patches to see if
there is any difference from upstream.

However, there is an additional process change what we can do here is
for the developer to list just the commit IDs for the patches to be
cherry picked in dts/upstream in the cover letter. This way the
maintainer can just directly use the tooling to cherry pick those
patches before applying the patch-set.

Tooling already available for cherry-picking subtree commits as:

$ ./tools/update-subtree.sh pick dts <devicetree-rebasing-commit-id>

-Sumit
